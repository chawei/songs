class Release < ActiveRecord::Base
  has_many :relationships, :as => :source, :dependent => :destroy
  has_many :songs, :through => :relationships, :source => :target, :source_type => 'Song'
  has_many :artists, :through => :relationships, :source => :target, :source_type => 'Artist'
  
  def primary_artist
    artists.first
  end
  
  def album_url
    large_image_url.blank? ? '/images/default_album.png' : large_image_url
  end
end
