require 'httparty'

class LastFm
  include HTTParty
  format :xml
  
  API_KEY = "e7edb890eedd0933d438dd90f1cde8e1"
  
  def self.get_artist_info(artist_name)
    res = self.get("http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist=#{URI.escape(artist_name)}&api_key=#{API_KEY}")
    return res
  end
end


