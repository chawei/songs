class QueueLink < ActiveRecord::Base
  scope :unimported, :conditions => ["imported IS NULL or imported = ?", false]
end
