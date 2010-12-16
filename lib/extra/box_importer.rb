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
  
  def self.import_album(album_link)
    doc = Nokogiri::HTML(open(album_link))
    
    cover_url = doc.css('#info .left-column img.cover')[0]['src']
    artist_name = doc.css("#breadcrumbs li a")[1].content
    album_name = doc.css('#info .right-column h3')[0].content
    album_year = doc.css('#info .right-column dl dd').children[1].content
    doc.css('.song-name a').each do |link|
      title = link.children[0].content
      lyric_content = get_lyrics("#{BOX_HOST}#{link['href']}")
      if lyric = Lyric.find_by_performer_name_and_title(artist_name, title)
        lyric.content = lyric_content if lyric.content.blank?
        lyric.album_name = album_name if lyric.album_name.blank?
      else      
        lyric = Lyric.new(:performer_name => artist_name, :writer_name => artist_name, :cover_url => cover_url, 
                          :title => title, :content => lyric_content, :album_name => album_name, :year => album_year)
      end
      
      if lyric.save
        print('.')
      else
        puts "Error] link: #{link}"
      end
      sleep(rand(5)+3)
    end
  end
end
  