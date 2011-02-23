class Song < ActiveRecord::Base  
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
  
  has_many :relationships, :as => :target, :dependent => :destroy
  has_many :releases, :through => :relationships, :source => :source, :source_type => 'Release'
  has_many :performers, :through => :relationships, :source => :source, :source_type => 'Artist', 
                        :conditions => { 'relationships.relationship_type' => 'perform' }
  has_many :writers, :through => :relationships, :source => :source, :source_type => 'Artist', 
                        :conditions => { 'relationships.relationship_type' => 'write' }
  
  validates_presence_of :title, :performer_name
  validates_uniqueness_of :title, :scope => [:performer_name]
  
  has_friendly_id :performer_name_and_title, :use_slug => true
  
  scope :recent_updated, lambda { { :conditions => ["created_at > ?", 2.weeks.ago] } }
  scope :limited, lambda { |num| { :limit => num } }
  scope :previous, lambda { |i| { :conditions => ["#{self.table_name}.id < ?", i.id], :order => "#{self.table_name}.id DESC"} }
  scope :next, lambda { |i| {:conditions => ["#{self.table_name}.id > ?", i.id], :order => "#{self.table_name}.id ASC"} }
  
  after_save :set_performer, :set_writer
  #after_create :get_youtube_video
        
  def set_performer
    unless artist = Artist.find_by_name(performer_name)
      artist = Artist.create(:name => performer_name, :full_name => performer_name)
    end
    Relationship.create(:source => artist, :target => self, :relationship_type => 'perform')
  end
  
  def performer
    return performers.last
  end
  
  def set_writer
    unless artist = Artist.find_by_name(writer_name)
      artist = Artist.create(:name => writer_name, :full_name => writer_name, :primary_position => 'writer')
    end
    Relationship.create(:source => artist, :target => self, :relationship_type => 'write')
  end
  
  def writer
    return writers.last
  end
  
  def performer_name_and_title
    "#{performer_name}-#{title}"
  end
  
  def main_release
    releases.where(:release_type => 'album').first
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
  
  def update_videos(new_video_url, video_title = nil, similarity_type = nil, viewer_id = nil)
    video = Video.new(:url => new_video_url, :created_by_id => viewer_id, 
                      :title => video_title, :similarity => similarity_type, :song_id => self.id)
    video.save
  end
  
  def get_youtube_video
    begin
      client = YouTubeG::Client.new
      query = "#{self.performer_name} #{self.title}"
      result = client.videos_by(:query => query)
      
      return if result.videos.length == 0
      
      exact_video_index    = []
      possible_video_index = []
      for video in result.videos
        # TODO: provide better algorithm to determine if this is the correct music video
        video_title        = Song.remove_puncuation(video.title)
        video_description  = Song.remove_puncuation(video.description)
        standardized_name  = Song.remove_puncuation(self.performer_name)
        standardized_title = Song.remove_puncuation(self.title)
        
        next if !video.embeddable?
        
        point = 0
        point += 1 if (video_title =~ /#{standardized_name}/i) || (video_description =~ /#{standardized_name}/i)
        point += 1 if (video_title =~ /#{standardized_title}/i) || (video_description =~ /#{standardized_title}/i)
        
        if point == 2
          exact_video_index << result.videos.index(video)
        elsif point == 1
          possible_video_index << result.videos.index(video)
        end
      end
      
      # Add the first search result even it is not the right one
      #if possible_video_index.length == 0
      #  possible_video_index << 0
      #end
      
      index_hash = {}
      if exact_video_index.length > 1
        index_hash['exact'] = exact_video_index[0..3]
      elsif possible_video_index.length > 1
        index_hash['possible'] = possible_video_index[0..3]
      else
        index_hash['first_result'] = [0]
      end

      index_hash.each do |similarity_type, video_index|
        video_index.each do |i|
          video = result.videos[i]
          if video_from_db = Video.find_by_uid_and_source(video.unique_id, 'youtube')
            video_from_db.similarity = similarity_type
            video_from_db.title = video.title
            video_from_db.save
            self.videos << video_from_db
          else
            self.update_videos("http://www.youtube.com/watch?v=#{video.unique_id}", video.title, similarity_type)
          end
        end
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
  
  def self.remove_puncuation(raw_title)
    return '' if raw_title.nil?
    raw_title.gsub(/[[:punct:]＠＃＄％！︿～＆＊－＝＋，、。「」（）；：＼｜]/, '')
  end
  
  def self.normalize_title(title)
    title = title.gsub(/(\(.*\))|(\[.*\])/, '')
    title = title.gsub(/[-_\/\\]/, ' ')
    return title.strip
  end
end
