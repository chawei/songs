# encoding: utf-8
require 'httparty'
require 'amazon/ecs'
require 'rbrainz'

class SongImporter
  include HTTParty
  include MusicBrainz
  format :xml

  API_KEY = "b25b959554ed76058ac220b7b2e0a026"
  ACCESS_KEY = 'AKIAJ6PXZ7USNNIKTG6Q'
  SECRET_KEY = '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'
  Amazon::Ecs.options = { :aWS_access_key_id => ACCESS_KEY, :aWS_secret_key => SECRET_KEY }
  
  def self.import_song(options)
    return if options[:query].blank?
    video_url = options[:video_url]
    if song = Video.get_song(video_url)
      return song
    end
    
    query = normalize_query(options[:query])
    q_lang = LanguageDetector.get_lang(query)
    puts "===== LanguageDetector ====="
    puts "Language: #{q_lang}"
    need_verify = !["zh-TW", "zh-CN", 'ja'].include?(q_lang)
    
    
    res = self.get("http://ws.audioscrobbler.com/2.0/?method=track.search&track=#{URI.escape(query)}&api_key=#{API_KEY}")
    if trackmatches = res['lfm']['results']['trackmatches']
      tracks = trackmatches['track']
      track = (tracks.is_a?(Hash) ? tracks : tracks[0])
      artist = track["artist"]
      title  = track["name"]
      
      puts "===== Last.fm ====="
      puts "Artist: #{artist}"
      puts "Title : #{title}"
        
      if song = Song.find_by_performer_name_and_title(artist, title)
        song.update_videos(options[:video_url], options[:current_user_id])
        puts "*** Found Data in DB"
        return song
      elsif song = LyricsFinder.get_song(:artist => artist, :title => title, :video_url => video_url, 
                                           :current_user_id => options[:current_user_id], :need_verify => need_verify)
        puts "*** Found Data by LyricsFinder"
        return song
      else
        # save as request
        return nil
      end
    end
    
    return nil
  end
  
  def self.normalize_query(query)
    query = query.gsub(/(\(.*\))|(\[.*\])|([mM][vV])|(完整版)|([wW]ith [lL]yrics)|([lL]yrics)/, '')
    query = query.gsub(/[-_\/\\]/, ' ')
    return query
  end
  
  def self.import_albums_by_artist_name(artist_name)
    import_albums_by_uuid(get_mbid(artist_name))
  end
  
  def self.get_mbid(artist_name)
    artist_filter = MusicBrainz::Webservice::ArtistFilter.new(:name => artist_name)
    query = Webservice::Query.new
    artists = query.get_artists(artist_filter)
    artist_uuid = artists[0].entity.id.uuid
    return artist_uuid
  end
  
  def self.import_albums_by_uuid(artist_uuid)
    artist_includes = Webservice::ArtistIncludes.new(
      :aliases      => true,
      :release_groups => true,
      :releases     => ['Album', 'Official'],
      :artist_rels  => true,
      :release_rels => true,
      :track_rels   => true,
      :label_rels   => true,
      :url_rels     => true
    )

    mbid = Model::MBID.new(artist_uuid, :artist)
    query = Webservice::Query.new
    m_artist = query.get_artist_by_id(mbid, artist_includes)
    artist_name = m_artist.name
    break if artist_name.blank?
    
    unless artist = Artist.find_by_name(artist_name)
      artist = Artist.create(:name => artist_name, :full_name => artist_name, :mbid => artist_uuid)
    end
    if artist.mbid.nil?
      artist.mbid = artist_uuid
      artist.save
    end
    
    m_artist.release_groups.each do |release_group|
      #release.id.uuid
      #release.asin
      #release = q.get_release_by_id(release_id, :artist=>true, :tracks=>true)
      album_name = release_group.title
      #album_images = get_album_cover_images(release_group)
      
      res = LastFm.get_album_info(artist_name, album_name)
      album_release_date = Time.parse(res['lfm']['album']['releasedate'])
      album_track_titles = []
      res['lfm']['album']['tracks']['track'].each do |t|
        album_track_titles << t['name'] if t['artist']['name'] == artist_name
      end
      
      unless release = Release.find_by_mbid(release_group.id.uuid)
        release = Release.create(:title => album_name, :release_date => album_release_date, 
                                 :release_type => 'album', :mbid => release_group.id.uuid)
      end
      
      begin
        release.artists << artist
      rescue
        puts "Duplicated Artist"
      end
      release.small_image_url  = res['lfm']['album']['image'][0] #album_images[:small][:url]
      release.medium_image_url = res['lfm']['album']['image'][1] #album_images[:medium][:url]
      release.large_image_url  = res['lfm']['album']['image'][2] #album_images[:large][:url]
      
      album_track_titles.each do |track_name|
        unless song = Song.find_by_performer_name_and_title(artist_name, track_name)
          song = Song.new(:performer_name => artist_name, :writer_name => artist_name, :title => track_name)
          song.save
        end
        release.songs << song
      end
      if release.save
        print '.'
      else
        print 'F'
      end
    end
  end
  
  def self.get_album_cover_images(release_group)
    images = {}
    
    album_title = release_group.title
    artist_name = release_group.artist.name
    #res = Amazon::Ecs.item_lookup('B00005OAIE', {:response_group => 'Images'})
    res = Amazon::Ecs.item_search("#{artist_name} #{album_title}", {:response_group => 'Images'})
    
    images[:small]  = res.items[0].try(:get_hash, 'smallimage')
    images[:medium] = res.items[0].try(:get_hash, 'mediumimage')
    images[:large]  = res.items[0].try(:get_hash, 'largeimage')
    
    return images
  end

end
