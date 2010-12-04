require 'httparty'

class SongImporter
  include HTTParty
  format :xml

  API_KEY = "b25b959554ed76058ac220b7b2e0a026"
  
  def self.import_song(options)
    return if options[:query].blank?
    
    query = options[:query].gsub(/(\(.*\))|(\[.*\])/, '')
    video_url = options[:video_url]
    
    res = self.get("http://ws.audioscrobbler.com/2.0/?method=track.search&track=#{URI.escape(query)}&api_key=#{API_KEY}")
    tracks = res['lfm']['results']['trackmatches']['track']
    if tracks.length > 0
      track = (tracks.is_a?(Hash) ? tracks : tracks[0])
      artist = track["artist"]
      title  = track["name"]
      
      puts "===== Last.fm ====="
      puts "Artist: #{artist}"
      puts "Title : #{title}"
      
      if lyric = Lyric.find_by_performer_and_title(artist, title)
        puts "*** Found Data in DB"
        return lyric
      elsif lyric = LyricsFinder.get_lyric(:artist => artist, :title => title, :video_url => video_url, 
                                           :current_user_id => options[:current_user_id])
        puts "*** Found Data by LyricsFinder"
        return lyric
      else
        # save as request
        return "no lyric"
      end
    end
    
    return "fail"
  end

end
