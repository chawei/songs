# encoding: utf-8
require 'open-uri'

class Mojim
  
  API_HOST = "http://mojim.com"
  
  def self.find(options)
    puts "Find from Mojim"
    link   = find_song_link(options[:artist_name], options[:song_title])
    lyrics = find_lyrics_by_link link
  end
  
  def self.find_song_link(artist_name, song_title)
    doc = Nokogiri::HTML(open("#{API_HOST}/#{URI.escape(song_title)}.html?t3"))
    
    doc.css("table.iB tr")[1..-1].each do |tr| 
      begin     
        artist_name_from_source = tr.css("td.iA a")[0].text
        song_title_from_source  = tr.css("td.iA a font")[0].text
        puts "#{artist_name_from_source} #{song_title_from_source}"
        if matching?(artist_name, artist_name_from_source, song_title, song_title_from_source)
          @song_link = tr.css("td.iA a")[2].attributes['href'].value
          puts "[Match] #{artist_name_from_source} #{song_title_from_source}"
          puts @song_link
          break
        end
      rescue
        puts "Error"
      end
    end
    
    return "#{API_HOST}#{@song_link}"
  end
  
  def self.matching?(song_title, song_title_from_kkbox, artist_name, artist_name_from_kkbox)
    (song_title =~ /#{song_title_from_kkbox}/ || song_title_from_kkbox =~ /#{song_title}/) && (artist_name =~ /#{artist_name_from_kkbox}/ || artist_name_from_kkbox =~ /#{artist_name}/)
  end
  
  def self.find_lyrics_by_link(link)
    results = link.scan(/\#(\d+)/)
    if results.length > 0
      track_num = results[0][0]
      doc = Nokogiri::HTML(open(link))
      lyrics_block = doc.css("a[name='#{track_num}']")[0].parent.next_sibling
      ["a", "ol", "script", "hr"].each do |tag|
        lyrics_block.css(tag).remove()
      end
      lyrics = lyrics_block.inner_html.gsub(/[\[00\:00\.00\]+].*$/, '').gsub("<br>轉載來自 <br>", '').gsub("<br>", "\n")
    else
      puts "Not Found"
    end
  end
end