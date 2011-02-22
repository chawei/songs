class Release < ActiveRecord::Base
  has_friendly_id :title, :use_slug => true
  
  #validates_uniqueness_of :title, :scope => [:performer_name]
  
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
      titles[0..-1].each do |title|
        parsed_title = title.strip
        if release = Release.find_by_title(parsed_title)
          if release.primary_artist == self.primary_artist
            self.songs.each do |song|
              begin
                release.songs << song
              rescue
                puts "-- Duplicated Song"
              end
            end
          end
        else
          release = Release.create(:title => parsed_title, :release_type => 'album')
          begin
            release.artists << self.primary_artist
          rescue
            puts "-- Duplicated Artist"
          end
          
          self.songs.each do |song|
            begin
              release.songs << song
            rescue
              puts "-- Duplicated Song"
            end
          end
        end
        puts "== Release ID: #{release.id} Title #{release.title}"
      end
    end
    self.destroy
  end
  
  def merge_releases
    releases = Release.where(:title => self.title)
    if releases.length > 1
      releases.each do |release|
        if release.primary_artist == self.primary_artist
          release.songs.each do |song|
            begin
              self.songs << song
            rescue
              puts "-- Duplicated Song"
            end
          end
          puts "== Delete Release ID: #{release.id} Title #{release.title}"
          release.destroy
        end
      end
    end
  end
end
