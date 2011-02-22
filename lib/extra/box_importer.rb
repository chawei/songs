# encoding: utf-8
require 'open-uri'

class BoxImporter
  
  BOX_HOST = "http://tw.kkbox.com"
  
  def self.get_lyrics(link)
    doc = Nokogiri::HTML(open(link))
    lyric_content = doc.css('#lyrics p')[0]
    lyric_content.search('br').each do |br|
      br.replace(Nokogiri::XML::Text.new("\n", lyric_content.document))
    end
    return lyric_content.content
  end
  
  def self.get_artist_url(artist_name)
    doc = Nokogiri::HTML(open("#{BOX_HOST}/search.php?word=#{URI.escape(artist_name)}&search=song&search_lang="))
    
    rows = doc.css('table tr')
    rows[1..-1].each do |row|
      if row.children[2].text =~ /#{artist_name}/
        return BOX_HOST+row.children[2].children[0].attributes['href'].value
      end
    end
    return nil
  end
  
  def self.import_artist(artist_name)
    if artist_link = get_artist_url(artist_name)
      puts "== Start importing artist: #{artist_name}"
      import_artist_albums(artist_link, artist_name)
      puts "== End importing artist: #{artist_name}"
    end
  end
  
  def self.import_artist_albums(artist_link, artist_name = nil)
    doc = Nokogiri::HTML(open(artist_link))
    artist_name = doc.css("#breadcrumbs li a")[1].content if artist_name.blank?
    artist_image_url = doc.css('#info .left-column img')[0]['src']
    artist = Artist.find_or_create_by_name(artist_name)
    artist.image_small_url = artist_image_url
    artist.image_large_url = artist_image_url
    artist.save
    
    doc.css("#all-albums li .item a.url").each do |link|
      import_album("#{BOX_HOST}#{link['href']}", artist)
      
      sleep_time = rand(10)+10
      puts "\n===== sleep #{sleep_time} secs ====="
      sleep(sleep_time)
    end
  end
  
  def self.import_album(album_link, artist)
    doc = Nokogiri::HTML(open(album_link))
    
    artist_name = artist.name
    cover_url = doc.css('#info .left-column img.cover')[0]['src']
    album_name = Song.normalize_title(doc.css('#info .right-column h3')[0].content)
    album_year = doc.css('#info .right-column dl dd').children[1].content.strip
    
    release = nil
    releases = artist.releases.where(:title => album_name)
    if releases.size > 0
      release = releases.first
    else
      release_date = parse_release_date(album_year)        
      release = Release.create(:title => album_name, 
                               :artist_name => artist_name, 
                               :release_date => release_date,
                               :release_type => 'album', 
                               :small_image_url => cover_url, 
                               :medium_image_url => cover_url,
                               :large_image_url => cover_url)
      artist.releases << release
    end
    
    puts "=== begin importing album: #{album_name} ====="
    
    tracks = doc.css('.song-name a')
    
    # TODO: add 'Force' option
    if release.songs.size >= tracks.size 
      puts "----- Skip -----"
    else
      tracks.each do |link|
        title = Song.normalize_title(link.children[0].content)
        lyric_content = get_lyrics("#{BOX_HOST}#{link['href']}")
        lyric_content = '' if lyric_content == "目前尚無相關歌詞"
        if song = Song.find_by_performer_name_and_title(artist_name, title)
          song.content = lyric_content if song.content.blank?
          if song.album_name.blank?
            song.album_name = album_name
          elsif !(song.album_name =~ /#{album_name}/)
            song.album_name += " | #{album_name}"
          end
          song.year       = album_year if song.year.blank?
          song.cover_url  = cover_url if song.cover_url.blank?
        else      
          song = Song.new(:performer_name => artist_name, :writer_name => artist_name, :cover_url => cover_url, 
                            :title => title, :content => lyric_content, :album_name => album_name, :year => album_year)
        end
      
        if song.save
          begin
            release.songs << song
          rescue
            puts "Duplicated Song"
          end
          print('.')
        else
          puts "Error] link: #{link}"
        end
        sleep(rand(5)+3)
      end
    end
    
    puts "\n=== finish importing album: #{album_name} ====="
  end
  
  def self.parse_release_date(raw_date)
    release_date = nil
    if raw_date =~ /\d{4}-\d{2}/
      date  = raw_date.split('-')
      year  = date[0]
      month = date[1]
      if month == '00'
        release_date = Date.strptime(year, "%Y")
      else
        begin 
          release_date = Date.strptime(raw_date, "%Y-%m")
        rescue
          puts "invalid release date"
        end
      end
    end
    return release_date
  end
  
  def self.normalize_str(str)
    str = str.gsub(/(\(.*\))/, '').strip
    return str
  end
end
  