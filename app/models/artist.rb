require 'open-uri'

class Artist < ActiveRecord::Base
  define_index do
    indexes name
  end
    
  has_attached_file :profile_image, :styles => { :large => "300x300>", 
                                                 :thumb => "100x100>" },
                                    :storage => :s3, 
                                    :s3_credentials => {
                                     :access_key_id => S3[:key],
                                     :secret_access_key => S3[:secret]
                                    },
                                    :bucket => S3[:bucket],
                                    :path => "artists/profile_image/:id/:style_:artist_name.:extension",
                                    :default_url => "/images/s3/artist_image/default_:style.png"
                           
  has_many :participations, :dependent => :destroy
  has_many :songs, :through => :participations
  has_many :events, :dependent => :destroy
  
  has_many :parent_relationships, :class_name => "Relationship", :as => :target, :dependent => :destroy
  has_many :releases, :through => :parent_relationships, :source => :source, :source_type => 'Release'
  
  has_many :relationships, :as => :source, :dependent => :destroy
  has_many :performed_songs, :through => :relationships, :source => :target, :source_type => 'Song',
                             :conditions => { 'relationships.relationship_type' => 'perform' }
  has_many :written_songs, :through => :relationships, :source => :target, :source_type => 'Song',
                           :conditions => { 'relationships.relationship_type' => 'write' }
  
  has_friendly_id :full_name, :use_slug => true
  
  validates_presence_of :name, :full_name
  
  before_validation :set_full_name
  before_create :set_default_values
  after_create  :add_queue_link
  after_create  :download_remote_image
  
  #def performed_songs
  #  return participations.performer.collect {|p| p.song}
  #end
  
  Paperclip.interpolates('artist_name') do |attachment, style|
    attachment.instance.friendly_id
  end
  
  def grab_info
    artist = Artist.find(self)
    res = LastFm.get_artist_info(artist.name)
    artist.bio_summary = res["lfm"]["artist"]["bio"]["summary"].try(:gsub, /<\/?[^>]*>/, "")
    artist.bio_full    = res["lfm"]["artist"]["bio"]["content"].try(:gsub, /<\/?[^>]*>/, "")
    artist.image_small_url = res["lfm"]["artist"]["image"][2]
    artist.image_large_url = res["lfm"]["artist"]["image"][4]
    artist.save
  end
  
  def preload_song_videos
    releases.each do |release|
      release.songs.each do |song|
        song.get_youtube_video
      end
    end
  end
  
  def update_songs_release
    puts "== Artist ID: #{self.id}, Name: #{self.name}"
    self.performed_songs.each do |song|
      puts "== Song ID: #{song.id}, Title: #{song.title}"
      release = nil
      unless song.main_release
        if song.album_name.blank?
          releases = self.releases.where(:title => "Unknown", :release_type => 'unknown')
          if releases.exists?
            release = releases.first
          else
            release = Release.create(:title => "Unknown", :release_type => 'unknown')
            self.releases << release
          end
        else
          album_name = song.album_name.strip
          releases = self.releases.where(:title => album_name)
          if releases.exists?
            release = releases.first
          else 
            release = Release.create(:title => album_name, :release_type => 'album')
            self.releases << release
          end
        end
        release.songs << song
        puts "== Release ID: #{release.id}, Title: #{release.title}"
      end
    end
  end
  
  def merge_releases
    self.releases.each do |arelease|
      releases = self.releases.where(:title => arelease.title)
      if releases.length > 1
        only_release = releases[0]
        releases[1..-1].each do |release|
          release.songs.each do |song|
            begin
              only_release.songs << song
            rescue
              puts "-- Duplicated Song"
            end
          end
          puts "== Delete Release ID: #{release.id} Title #{release.title}"
          release.destroy
        end
      end
    end
  end
  
  def download_remote_image
    if self.image_large_url
      self.profile_image = do_download_remote_image
      self.save
    end
  end
  
  protected
  
    def set_full_name
      if self.full_name.nil?
        self.full_name = self.name
      end
    end
  
    def set_default_values
      self.artist_type ||= 'individual'
      self.primary_position ||= 'performer'
      self.secondary_position ||= 'writer'
      self.lang = 'zh-TW' if LanguageDetector.asian_language?(self.name)
    end
    
    def do_download_remote_image
      io = open(URI.parse(image_large_url))
      def io.original_filename; base_uri.path.split('/').last; end
      io.original_filename.blank? ? nil : io
    rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
    end
    
    def add_queue_link
      QueueLink.create(:artist_name => self.name)
    end
end
