class Lyric < ActiveRecord::Base
  belongs_to :created_by, :class_name => "User", :foreign_key => 'created_by_id'
  belongs_to :updated_by, :class_name => "User", :foreign_key => 'updated_by_id'
  
  has_many :background_stories, :dependent => :destroy
  has_many :notes, :dependent => :destroy
  
  validates_presence_of :title, :performer
  
  has_friendly_id :performer_and_title, :use_slug => true
  
  scope :recent_updated, lambda { { :conditions => ["created_at > ?", 2.weeks.ago] } }
  scope :limited, lambda { |num| { :limit => num } }
  
  def performer_and_title
    "#{performer}-#{title}"
  end
  
  def youtube_id
    video_url.blank? ? nil : video_url.match(/\?v=(.*)/)[1]
  end
end
