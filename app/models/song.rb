class Song < ActiveRecord::Base
  require 'youtube_g'
  
  define_index do
    indexes title, performer_name
  end
  
  acts_as_voteable
   
  belongs_to :created_by, :class_name => "User", :foreign_key => 'created_by_id'
  belongs_to :updated_by, :class_name => "User", :foreign_key => 'updated_by_id'
  
  has_many :background_stories, :dependent => :destroy
  has_many :notes, :dependent => :destroy
  has_many :videos, :dependent => :destroy
  
  has_many :participations, :dependent => :destroy
  has_many :artists, :through => :participations
  
  has_many :relationships, :as => :target
  has_many :releases, :through => :relationships, :source => :source, :source_type => 'Release'
  
  validates_presence_of :title, :performer_name
  
  has_friendly_id :performer_name_and_title, :use_slug => true
  
  scope :recent_updated, lambda { { :conditions => ["created_at > ?", 2.weeks.ago] } }
  scope :limited, lambda { |num| { :limit => num } }
  scope :previous, lambda { |i| { :conditions => ["#{self.table_name}.id < ?", i.id], :order => "#{self.table_name}.id DESC"} }
  scope :next, lambda { |i| {:conditions => ["#{self.table_name}.id > ?", i.id], :order => "#{self.table_name}.id ASC"} }
  
  after_save :set_performer, :set_writer
  
  def set_performer
    unless artist = Artist.find_by_name(performer_name)
      artist = Artist.create(:name => performer_name, :full_name => performer_name)
    end
    unless Participation.find_by_artist_id_and_song_id_and_participation_type(artist.id, self.id, 'performer')
      Participation.create(:artist => artist, :song => self, :participation_type => 'performer')
    end
  end
  
  def performer
    performers = participations.performer
    if performers.empty?
      return nil
    else
      return performers.last.artist
    end
  end
  
  def set_writer
    unless artist = Artist.find_by_name(writer_name)
      artist = Artist.create(:name => writer_name, :full_name => writer_name, :primary_position => 'writer')
    end
    unless Participation.find_by_artist_id_and_song_id_and_participation_type(artist.id, self.id, 'writer')
      Participation.create(:artist => artist, :song => self, :participation_type => 'writer')
    end
  end
  
  def writer
    writers = participations.writer
    if writers.empty?
      return nil
    else
      return writers.last.artist
    end
  end
  
  def performer_name_and_title
    "#{performer_name}-#{title}"
  end
  
  def main_release
    releases.first
  end
  
  def refresh_lyrics
    current_time = Time.now
    self.lyrics_last_updated = current_time - 11.days if self.lyrics_last_updated.nil?
    if self.lyrics_last_updated + 10.days < current_time
      self.lyrics_last_updated = current_time
      
      result = LyricsFinder.musixmatch_search(:artist => performer.name, :title => title)
      self.content = result[:lyric] unless result.nil? || result[:lyric].blank?
    end
    self.save
  end
  
  def youtube_id
    video_url.blank? ? nil : video_url.match(/[\?|\&]v=([\w_-]*)/)[1]
  end
  
  def video_url=(url)
    self.update_videos(url) unless url.blank?
  end
  
  def update_videos(new_video_url, viewer_id = nil)
    video = Video.new(:url => new_video_url, :created_by_id => viewer_id)
    if video.save
      self.videos << video
    end
  end
  
  def get_youtube_video
    begin
      client = YouTubeG::Client.new
      query = "#{self.performer_name} #{self.title}"
      result = client.videos_by(:query => query)
      for video in result.videos
        # TODO: provide better algorithm to determine if this is the correct music video
        #next if !(video.title =~ /#{self.performer_name}/i) || !(video.description =~ /#{self.performer_name}/i)
        #next if !(video.title =~ /#{self.title}/i) || !(video.description =~ /#{self.title}/i)
        if video.embeddable?
          if video_from_db = Video.find_by_uid_and_source(video.unique_id, 'youtube')
            self.videos << video_from_db
          else
            self.video_url = "http://www.youtube.com/watch?v=#{video.unique_id}"
          end
        end
        break if self.videos.length > 3
      end  
    rescue => e
      message =  "[YouTubeG] Error when getting video with query##{query}"
      if defined?(HoptoadNotifier) == "constant"
        HoptoadNotifier.notify(:error_class => e.class.name, :error_message => "#{e.message} | #{message}")
      end
      puts message
    end
  end
  
  def next(limit = 1)
    items = self.class.next(self).find(:all, :limit => (limit || 1))
    return nil if items.empty?
    items.size == 1 ? items.first : items
  end
end
