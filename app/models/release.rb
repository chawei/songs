class Release < ActiveRecord::Base
  has_friendly_id :title, :use_slug => true
  
  has_many :relationships, :as => :source, :dependent => :destroy
  has_many :songs, :through => :relationships, :source => :target, :source_type => 'Song'
  has_many :artists, :through => :relationships, :source => :target, :source_type => 'Artist'
  
  def primary_artist
    artists.first
  end
  
  def album_url(size = 'large')
    case size
    when 'large'
      (large_image_url.blank? || large_image_url == 'sizelarge') ? '/images/default_album.png' : large_image_url
    when 'medium'
      (medium_image_url.blank? || medium_image_url == 'sizemedium') ? '/images/default_album.png' : medium_image_url
    end
  end
end
