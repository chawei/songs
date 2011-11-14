class RawSong
  attr_reader   :lang
  attr_accessor :artist_name, :song_title
  
  def initialize(options)
    @artist_name = options[:artist_name]
    @song_title  = options[:song_title]
    find_lang("#{@artist_name} #{@song_title}")
  end
  
  def find_lang(str)
    @lang = LanguageDetector.get_lang(str)
    puts "===== LanguageDetector ====="
    puts "Language: #{@lang}"
    @lang
  end
end