# encoding: utf-8
require 'httparty'

class SongImporter
  include HTTParty
  format :xml

  API_KEY = "b25b959554ed76058ac220b7b2e0a026"
  
  def self.import_song(options)
    return if options[:query].blank?
    
    query = normalize_query(options[:query])
    q_lang = LanguageDetector.get_lang(query)
    puts "===== LanguageDetector ====="
    puts "Language: #{q_lang}"
    need_verify = !["zh-TW", "zh-CN", 'ja'].include?(q_lang)
    
    video_url = options[:video_url]
    
    res = self.get("http://ws.audioscrobbler.com/2.0/?method=track.search&track=#{URI.escape(query)}&api_key=#{API_KEY}")
    if trackmatches = res['lfm']['results']['trackmatches']
      tracks = trackmatches['track']
      track = (tracks.is_a?(Hash) ? tracks : tracks[0])
      artist = track["artist"]
      title  = track["name"]
      
      puts "===== Last.fm ====="
      puts "Artist: #{artist}"
      puts "Title : #{title}"
        
      if lyric = Lyric.find_by_performer_and_title(artist, title)
        lyric.update_videos(options[:video_url])
        puts "*** Found Data in DB"
        return lyric
      elsif lyric = LyricsFinder.get_lyric(:artist => artist, :title => title, :video_url => video_url, 
                                           :current_user_id => options[:current_user_id], :need_verify => need_verify)
        puts "*** Found Data by LyricsFinder"
        return lyric
      else
        # save as request
        return nil
      end
    end
    
    return nil
  end
  
  def self.normalize_query(query)
    query = query.gsub(/(\(.*\))|(\[.*\])|([mM][vV])|(完整版)|/, '')
    query = query.gsub(/[-_\/\\]/, ' ')
    return query
  end

end
