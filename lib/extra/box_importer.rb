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
  
  def self.import_artist_albums(artist_link, artist_name = nil)
    doc = Nokogiri::HTML(open(artist_link))
    
    doc.css("#all-albums li .item a.url").each do |link|
      import_album("#{BOX_HOST}#{link['href']}", artist_name)
      
      sleep_time = rand(10)+10
      puts "\n===== sleep #{sleep_time} secs ====="
      sleep(sleep_time)
    end
  end
  
  def self.import_album(album_link, artist_name = nil)
    doc = Nokogiri::HTML(open(album_link))
    
    cover_url = doc.css('#info .left-column img.cover')[0]['src']
    if artist_name.blank?
      artist_name = doc.css("#breadcrumbs li a")[1].content
    end
    album_name = doc.css('#info .right-column h3')[0].content
    album_year = doc.css('#info .right-column dl dd').children[1].content
    
    puts "=== begin importing album: #{album_name} ====="
    doc.css('.song-name a').each do |link|
      title = link.children[0].content
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
        print('.')
      else
        puts "Error] link: #{link}"
      end
      sleep(rand(5)+3)
    end
    
    puts "\n=== finish importing album: #{album_name} ====="
  end
end
  