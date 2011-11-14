require 'httparty'

class LyricsFinder
  include HTTParty
  format :xml
  
  MUSIXMATCH_ROOT_URL = "http://api.musixmatch.com/ws/1.1/"
  MUSIXMATCH_API_KEY  = "7f27fb14d4d9bd1197cfc3a1613d6113"
  
  def self.get_song(options)
    result, raw_result, song = nil, nil, nil
    unless song = Song.find_by_performer_name_and_title(options[:artist], options[:title])
      song = Song.create(:performer_name => options[:artist], 
                         :writer_name => options[:artist], 
                         :title => options[:title], 
                         :video_url => options[:video_url], 
                         :created_by_id => options[:current_user_id])
    end
    
    begin
      if raw_result = musixmatch_search(options)
        result = raw_result
      #elsif raw_result = direct_chartlyrics_search(options)
      #  result = raw_result
      #elsif raw_result = advanced_lyric_search(options)
      #  result = raw_result
      end
      
      if result
        artist    = result[:artist]
        title     = result[:title]
        lyric     = result[:lyric]
        cover_url = result[:cover_url]
        
        # make sure the title is matched
        if song = Song.find_by_performer_name_and_title(artist, title)
          song.content = lyric
          song.cover_url = cover_url
          song.save
        end
        
        if lyric.blank?
          Request.create(:query_url => "/songs/#{song.id}", 
                         :request_type => 'lyrics', :user_id => options[:current_user_id])
        end
      end
    rescue
      puts "error - please try later."
    end
    return song
  end
  
  def self.find_lyrics(artist_name, song_title)
    is_asian_song = SongFinder.is_asian_song?("#{artist_name} #{song_title}")
    
    if is_asian_song
      if lyrics = Mojim.find(:artist_name => artist_name, :song_title => song_title)
        return lyrics
      else
        return lyrics = BoxImporter.search_lyrics(artist_name, song_title)
      end
    else
      result = musixmatch_search(:artist => artist_name, :title => song_title)
      if result && 
        result[:artist].downcase == artist_name.downcase && 
        result[:title].downcase == song_title.downcase
        return result[:lyric]
      else
        return nil
      end
    end
  end
  
  def self.musixmatch_search(options)
    begin
      output = nil
      query_artist = options[:artist]
      
      res = self.get("#{MUSIXMATCH_ROOT_URL}track.search?apikey=#{MUSIXMATCH_API_KEY}&q_artist=#{URI.escape(query_artist)}&q_track=#{URI.escape(options[:title])}&format=xml&page_size=1&f_has_lyrics=1")
            
      if res['message']['body']
        artist     = res['message']['body']['track_list']['track']['artist_name']
        title      = res['message']['body']['track_list']['track']['track_name']
        track_id   = res['message']['body']['track_list']['track']['track_id']
        
        lyrics_res = self.get("#{MUSIXMATCH_ROOT_URL}track.lyrics.get?track_id=#{track_id}&format=xml&apikey=#{MUSIXMATCH_API_KEY}")
        lyric      = lyrics_res['message']['body']['lyrics']['lyrics_body']
        
        output = {:artist => artist, :title => title, :lyric => lyric, :cover_url => nil}
      #  if options[:need_verify] 
      #    output = nil unless artist.downcase == query_artist.downcase && !options[:title].downcase.match(/#{title.downcase}/).nil?
      #  end
      end
    
      return output
    rescue
      puts "[Error] MusixMatch #{res}"
      return nil
    end
  end
  
  def self.direct_chartlyrics_search(options)
    begin
      output = nil
      query_artist = options[:artist]
      
      res = self.get("http://api.chartlyrics.com/apiv1.asmx/SearchLyricDirect?artist=#{URI.escape(query_artist)}&song=#{URI.escape(options[:title])}")
      if res["GetLyricResult"].length > 0
        artist    = res["GetLyricResult"]["LyricArtist"]
        title     = res["GetLyricResult"]["LyricSong"]
        lyric     = res["GetLyricResult"]["Lyric"]
        cover_url = res["GetLyricResult"]["LyricCovertArtUrl"]
        
        output = {:artist => artist, :title => title, :lyric => lyric, :cover_url => cover_url}
        if options[:need_verify] 
          output = nil unless artist.downcase == query_artist.downcase && !options[:title].downcase.match(/#{title.downcase}/).nil?
        end
      end
    
      return output
    rescue
      puts "[Error] SearchLyricDirect #{res}"
      return nil
    end
  end
    
  def self.advanced_lyric_search(options)
    @output = nil
    begin
      res = self.get("http://api.chartlyrics.com/apiv1.asmx/SearchLyric?artist=#{URI.escape(options[:artist])}&song=#{URI.escape(options[:title])}")
      if res["ArrayOfSearchLyricResult"]["SearchLyricResult"].length > 1
        results = res["ArrayOfSearchLyricResult"]["SearchLyricResult"]
        lyric_id, checksum = nil, nil
        for result in results do
          title = result['Song'].downcase
          if result['Artist'].downcase == options[:artist].downcase and !options[:title].downcase.match(/#{title.downcase}/).nil?
            lyric_id  = result["LyricId"]
            checksum  = result["LyricChecksum"]
            break
          end
        end
      
        if lyric_id != "0" and !lyric_id.nil? and !checksum.nil?
          l_res = self.get("http://api.chartlyrics.com/apiv1.asmx/GetLyric?lyricId=#{lyric_id}&lyricCheckSum=#{checksum}")
          artist    = l_res["GetLyricResult"]["LyricArtist"]
          title     = l_res["GetLyricResult"]["LyricSong"]
          lyric     = l_res["GetLyricResult"]["Lyric"]
          cover_url = l_res["GetLyricResult"]["LyricCovertArtUrl"]
          @output = { :artist => artist, :title => title, :lyric => lyric, :cover_url => cover_url }
        end
      end
      return @output
    rescue
      puts "[Error] SearchLyric #{res.inspect}"
      return nil
    end
  end

end
