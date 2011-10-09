class Lyric < ActiveRecord::Base
  belongs_to :song
  
  validates_presence_of   :song_id, :content
  validates_uniqueness_of :song_id
end
