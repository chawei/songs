class SongFinder
  attr_accessor :query, :artist_name, :song_title
  
  def self.find(options)
    @finder = self.new
    return if options[:query].blank?
    
    begin
      puts "Video URL: #{options[:video_url]}"
      if options[:video_url].present? && @song = Video.find_song_by_url(options[:video_url])
        return @song
      end
    rescue => e
      puts "[Video Not Found] #{e}"
    end
    
    @finder.set_artist_name_and_song_title(options[:query])
    return nil if @finder.artist_name.nil? && @finder.song_title.nil?
    return Song.find_via_artist_name_and_song_title(@finder.artist_name, @finder.song_title, options)
  end
  
  def self.normalize_query(query)
    query = query.gsub(/(\(.*\))|(\[.*\])|([mM][vV])|(完整版)|([wW]ith [lL]yrics)|([lL]yrics)/, '')
    query = query.gsub(/[-_\/\\]/, ' ')
    return query
  end
  
  def self.is_asian_song?(query)
    q_lang = LanguageDetector.get_lang(query)
    puts "===== LanguageDetector ====="
    puts "Language: #{q_lang}"
    return ["zh-TW", "zh-CN", 'ja'].include?(q_lang)
  end
  
  def set_artist_name_and_song_title(query)
    @query = SongFinder.normalize_query(query)
    
    if res = LastFm.get_title_and_artist_name(@query)    
      @artist_name = res[:artist_name]
      @song_title  = res[:title]
    end
  end
end