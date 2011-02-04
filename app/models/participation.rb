class Participation < ActiveRecord::Base
  belongs_to :artist
  belongs_to :song
  
  validates_uniqueness_of :artist_id, :scope => [:song_id, :participation_type]
  validates_presence_of :artist_id, :song_id, :participation_type
  
  scope :performer, :conditions => { :participation_type => 'performer' }
  scope :writer,    :conditions => { :participation_type => 'writer' }
end
