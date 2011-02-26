class QueueLink < ActiveRecord::Base
  validates_presence_of :artist_name
  validates_uniqueness_of :artist_name
  
  default_scope :order => 'created_at DESC'
  scope :unimported, :conditions => ["imported IS NULL or imported = ?", false]
  
  before_create :initialize_imported
  
  private
  
    def initialize_imported
      self.imported = false if imported.nil?
    end
end
