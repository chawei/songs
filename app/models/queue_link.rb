class QueueLink < ActiveRecord::Base
  validates_presence_of :artist_name
  
  default_scope :order => 'created_at DESC'
  scope :unimported, :conditions => ["imported IS NULL or imported = ?", false]
end
