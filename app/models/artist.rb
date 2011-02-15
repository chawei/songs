class Artist < ActiveRecord::Base
  define_index do
    indexes name
  end
  
  has_many :participations, :dependent => :destroy
  has_many :songs, :through => :participations
  has_many :events, :dependent => :destroy
  
  has_friendly_id :full_name, :use_slug => true
  
  validates_presence_of :name, :full_name
  
  before_create :set_default_values
  
  def performed_songs
    return participations.performer.collect {|p| p.song}
  end
  
  def grab_info
    res = LastFm.get_artist_info(self.name)
    self.bio_summary = res["lfm"]["artist"]["bio"]["summary"].gsub(/<\/?[^>]*>/, "")
    self.bio_full    = res["lfm"]["artist"]["bio"]["content"].gsub(/<\/?[^>]*>/, "")
    self.image_small_url = res["lfm"]["artist"]["image"][2]
    self.image_large_url = res["lfm"]["artist"]["image"][4]
    self.save
  end
  
  protected
  
    def set_default_values
      self.artist_type ||= 'individual'
      self.primary_position ||= 'performer'
      self.secondary_position ||= 'writer'
    end
end
