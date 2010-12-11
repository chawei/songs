class Artist < ActiveRecord::Base
  has_many :participations, :dependent => :destroy
  has_many :lyrics, :through => :participations
  
  has_friendly_id :full_name, :use_slug => true
  
  validates_presence_of :name, :full_name
  
  before_create :set_default_values
  
  def getInfo
    
  end
  
  protected
  
    def set_default_values
      self.artist_type ||= 'individual'
      self.primary_position ||= 'performer'
      self.secondary_position ||= 'writer'
    end
end
