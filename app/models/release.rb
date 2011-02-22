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
  
  def separate_releases
    titles = self.title.split('|')
    if titles.length > 1
      self.title = titles[0].strip
      self.save
      titles[1..-1].each do |title|
        parsed_title = title.strip
        if release = Release.find_by_title(parsed_title)
          if release.primary_artist == self.primary_artist
            release.songs << self.songs
          end
        else
          release = Release.create(:title => parsed_title, :release_type => 'album')
          release.artists << self.primary_artist
          release.songs << self.songs
        end
        puts "== Release ID: #{release.id} Title #{release.title}"
      end
    end
  end
end
