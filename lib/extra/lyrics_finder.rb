require 'httparty'

class LyricsFinder
  include HTTParty
  format :xml

  DEVELOPER_KEY = "6bb71335d98954463-temporary.API.access"
  
  def self.get_lyric(options)
    
    result, raw_result = nil, nil
    begin
      if raw_result = direct_chartlyrics_search(options)
        result = raw_result
      elsif raw_result = advanced_lyric_search(options)
        result = raw_result
      end
      
      if result
        artist    = result[:artist]
        title     = result[:title]
        lyric     = result[:lyric]
        cover_url = result[:cover_url]
        
        song = Lyric.find_by_performer_and_title(artist, title)
        if song.nil?
          song = Lyric.create(:performer => artist, :writer => artist, :title => title, :content => lyric, 
                              :cover_url => cover_url, :video_url => options[:video_url], :created_by_id => options[:current_user_id])
        end
        return song
      else
        song = Lyric.create(:performer => options[:artist], :writer => options[:artist], :title => options[:title],
                            :video_url => options[:video_url], :created_by_id => options[:current_user_id])
        return song
      end
    rescue
      return "error - please try later."
    end
    #self.get("http://api.lyricsfly.com/api/api.php?i=#{DEVELOPER_KEY}&a=#{options[:artist]}&t=#{options[:title]}")
  end
  
  def self.direct_chartlyrics_search(options)
    begin
      output = nil
    
      res = self.get("http://api.chartlyrics.com/apiv1.asmx/SearchLyricDirect?artist=#{URI.escape(options[:artist])}&song=#{URI.escape(options[:title])}")
      if res["GetLyricResult"].length > 0
        res     = res
        artist    = res["GetLyricResult"]["LyricArtist"]
        title     = res["GetLyricResult"]["LyricSong"]
        lyric     = res["GetLyricResult"]["Lyric"]
        cover_url = res["GetLyricResult"]["LyricCovertArtUrl"]
      
        if artist.downcase == options[:artist].downcase and !options[:title].downcase.match(/#{title.downcase}/).nil?
          output = {:artist => artist, :title => title, :lyric => lyric, :cover_url => cover_url}
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
