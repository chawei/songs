# encoding: utf-8
require 'open-uri'
require 'httparty'

class LastFm
  include HTTParty
  format :xml
  
  API_PATH = "http://ws.audioscrobbler.com/2.0/"
  API_KEY = "e7edb890eedd0933d438dd90f1cde8e1"
  
  def self.get_artist_info(artist_name)
    res = self.get("#{API_PATH}?method=artist.getinfo&artist=#{URI.escape(artist_name)}&api_key=#{API_KEY}")
    return res
  end
  
  def self.from_taiwan?(artist_name)
    res = self.get("#{API_PATH}?method=artist.gettoptags&artist=#{URI.escape(artist_name)}&api_key=#{API_KEY}")
    res['lfm']['toptags']['tag'].each do |tag|
      if tag['name'] =~ /taiwan/
        return true
      end
    end
    return false
  end
  
  def self.get_tracks_by_url(album_link)
    track_names = []
    doc = Nokogiri::HTML(open(album_link))
    tracks = doc.css('#albumTracklist tr .subjectCell')
    tracks.each do |track|
      track_name = track.children[1].content
      track_names << track_name
    end
    return track_names
  end
  
  def self.get_album_info(artist_name, album_name)
    res = self.get("#{API_PATH}?method=album.getinfo&artist=#{URI.escape(artist_name)}&album=#{URI.escape(album_name)}&api_key=#{API_KEY}")
    return res
  end
  
  def self.import_top_albums(artist_name)
    top_albums = self.get("http://ws.audioscrobbler.com/2.0/?method=artist.gettopalbums&artist=#{URI.escape(artist_name)}&autocorrect=1&api_key=#{API_KEY}")
    return top_albums
  end
end


