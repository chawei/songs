class Lyric < ActiveRecord::Base
  belongs_to :created_by, :class_name => "User", :foreign_key => 'created_by_id'
  belongs_to :updated_by, :class_name => "User", :foreign_key => 'updated_by_id'
  
  has_many :background_stories, :dependent => :destroy
  has_many :notes, :dependent => :destroy
  has_many :videos, :dependent => :destroy
  
  has_many :participations, :dependent => :destroy
  has_many :artists, :through => :participations
  
  validates_presence_of :title, :performer_name
  
  has_friendly_id :performer_name_and_title, :use_slug => true
  
  scope :recent_updated, lambda { { :conditions => ["created_at > ?", 2.weeks.ago] } }
  scope :limited, lambda { |num| { :limit => num } }
  
  after_save :set_performer, :set_writer
  
  def set_performer
    unless artist = Artist.find_by_name(performer_name)
      artist = Artist.create(:name => performer_name, :full_name => performer_name)
    end
    unless Participation.find_by_artist_id_and_lyric_id_and_participation_type(artist.id, self.id, 'performer')
      Participation.create(:artist => artist, :lyric => self, :participation_type => 'performer')
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
    unless Participation.find_by_artist_id_and_lyric_id_and_participation_type(artist.id, self.id, 'writer')
      Participation.create(:artist => artist, :lyric => self, :participation_type => 'writer')
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
  
  def youtube_id
    video_url.blank? ? nil : video_url.match(/[\?|\&]v=([\w_-]*)/)[1]
  end
  
  def video_url=(url)
    self.update_videos(url)
  end
  
  def update_videos(new_video_url, viewer_id = nil)
    video = Video.new(:url => new_video_url, :created_by_id => viewer_id)
    if video.save
      self.videos << video
    end
  end
end
