class Release < ActiveRecord::Base
  # 4 types: album, single, compilation, live
  
  has_friendly_id :title, :use_slug => true
  
  has_attached_file :cover_image, :styles => { :large  => "300x300>", 
                                               :medium => "150x150>",
                                               :thumb  => "75x75>" },
                                    :storage => :s3, 
                                    :s3_credentials => {
                                     :access_key_id => S3[:key],
                                     :secret_access_key => S3[:secret]
                                    },
                                    :bucket => S3[:bucket],
                                    :path => "releases/cover_image/:id/:style_:release_title.:extension",
                                    :default_url => "/images/s3/cover_image/default_:style.png"
                                    
  validates_uniqueness_of :title, :scope => [:artist_name]
  
  has_many :relationships, :as => :source, :dependent => :destroy
  has_many :songs, :through => :relationships, :source => :target, :source_type => 'Song'
  has_many :artists, :through => :relationships, :source => :target, :source_type => 'Artist'
  
  after_create :download_remote_image
  
  Paperclip.interpolates('release_title') do |attachment, style|
    attachment.instance.friendly_id
  end
  
  def primary_artist
    if artists.exists?
      artist = Artist.find_by_id(artists.first.id)
    end
    return artist
  end
  
  def album_url(size = 'large')
    case size
    when 'large'
      (large_image_url.blank? || large_image_url == 'sizelarge') ? '/images/default_album.png' : large_image_url
    when 'medium'
      (medium_image_url.blank? || medium_image_url == 'sizemedium') ? '/images/default_album.png' : medium_image_url
    end
  end
  
  def separate_releases
    titles = self.title.split('|')
    if titles.length > 1
      titles[0..-1].each do |title|
        parsed_title = title.strip
        if release = Release.find_by_title(parsed_title)
          if release.primary_artist == self.primary_artist
            self.songs.each do |song|
              begin
                release.songs << song
              rescue
                puts "-- Duplicated Song"
              end
            end
          end
        else
          release = Release.create(:title => parsed_title, :release_type => 'album')
          begin
            release.artists << self.primary_artist
          rescue
            puts "-- Duplicated Artist"
          end
          
          self.songs.each do |song|
            begin
              release.songs << song
            rescue
              puts "-- Duplicated Song"
            end
          end
        end
        puts "== Release ID: #{release.id} Title #{release.title}"
      end
    end
    self.destroy
  end
  
  def download_remote_image
    if self.large_image_url
      self.cover_image = do_download_remote_image
      self.save
    end
  end
  
  private
  
    def do_download_remote_image
      io = open(URI.parse(large_image_url))
      def io.original_filename; base_uri.path.split('/').last; end
      io.original_filename.blank? ? nil : io
    rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
    end
end
