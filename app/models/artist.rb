class Artist < ActiveRecord::Base
  define_index do
    indexes name
  end
  
  has_many :participations, :dependent => :destroy
  has_many :songs, :through => :participations
  has_many :events, :dependent => :destroy
  
  has_many :parent_relationships, :class_name => "Relationship", :as => :target, :dependent => :destroy
  has_many :releases, :through => :parent_relationships, :source => :source, :source_type => 'Release'
  
  has_many :relationships, :as => :source, :dependent => :destroy
  has_many :performed_songs, :through => :relationships, :source => :target, :source_type => 'Song',
                             :conditions => { 'relationships.relationship_type' => 'perform' }
  has_many :written_songs, :through => :relationships, :source => :target, :source_type => 'Song',
                           :conditions => { 'relationships.relationship_type' => 'write' }
  
  has_friendly_id :full_name, :use_slug => true
  
  validates_presence_of :name, :full_name
  
  before_validation :set_full_name
  before_create :set_default_values
  
  #def performed_songs
  #  return participations.performer.collect {|p| p.song}
  #end
  
  def grab_info
    artist = Artist.find(self)
    res = LastFm.get_artist_info(artist.name)
    artist.bio_summary = res["lfm"]["artist"]["bio"]["summary"].try(:gsub, /<\/?[^>]*>/, "")
    artist.bio_full    = res["lfm"]["artist"]["bio"]["content"].try(:gsub, /<\/?[^>]*>/, "")
    artist.image_small_url = res["lfm"]["artist"]["image"][2]
    artist.image_large_url = res["lfm"]["artist"]["image"][4]
    artist.save
  end
  
  def preload_song_videos
    releases.each do |release|
      release.songs.each do |song|
        song.get_youtube_video
      end
    end
  end
  
  protected
  
    def set_full_name
      if self.full_name.nil?
        self.full_name = self.name
      end
    end
  
    def set_default_values
      self.artist_type ||= 'individual'
      self.primary_position ||= 'performer'
      self.secondary_position ||= 'writer'
    end
end
