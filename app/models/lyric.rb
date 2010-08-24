class Lyric < ActiveRecord::Base
  belongs_to :created_by, :class_name => "User", :foreign_key => 'created_by_id'
  belongs_to :updated_by, :class_name => "User", :foreign_key => 'updated_by_id'
  
  has_many :background_stories, :dependent => :destroy
  has_many :notes, :dependent => :destroy
  
  validates_presence_of :title, :performer, :content
  
  has_friendly_id :performer_and_title, :use_slug => true
  
  def performer_and_title
    "#{performer}-#{title}"
  end
end
