namespace :update do
  desc "move video_url to video model"
  task :video => :environment do
    Song.all.each do |song|
      puts "== ID: #{song.id}, URL: #{song.video_url}"
      song.update_videos(song.video_url, song.created_by_id)
    end
  end
  
  desc "update video title"
  task :video_title => :environment do
    client = YouTubeG::Client.new
    Video.all.each do |video|
      puts "== ID: #{video.id}, URL: #{video.url}"
      next if video.uid.blank?
      
      begin
        res_video = client.video_by(video.uid)
      rescue
        video.destroy
        puts "Error on YoutubeG"
        next
      end
      
      if res_video
        if res_video.embeddable?
          video.title = res_video.title
          video.save
        else
          video.destroy
        end
      end
    end
  end
  
  task :artist => :environment do
    Song.all.each do |song|
      puts "== ID: #{song.id}, Performer: #{song.performer_name}"
      ['performer', 'writer'].each do |artist_type|
        artist_name = song.send("#{artist_type}_name")
        unless artist_name.blank?
          artist = nil
          unless artist = Artist.find_by_name(artist_name)
            artist = Artist.create(:name => artist_name, :full_name => artist_name)
          end
          Participation.create(:artist_id => artist.id, :song_id => song.id, :participation_type => artist_type)
        end
      end
    end
  end
  
  desc "delete duplicated songs that have similar titles"
  task :delete_duplicated_songs => :environment do
    Song.find_in_batches do |songs|
      songs.each do |song|
        puts "== ID: #{song.id}, Title: #{song.title}"
        song.title = Song.normalize_title(song.title)
        unless song.save
          song.destroy
        end
      end
    end
  end
  
  desc "merge participation to relationship"
  task :merge_participation => :environment do
    Song.find_in_batches do |songs|
      songs.each do |song|
        puts "== ID: #{song.id}, Title: #{song.title}"
        song.save
      end
    end
  end
  
  desc "update albums by album_name"
  task :albums_by_album_name => :environment do
    Artist.find_in_batches do |artists|
      artists.each do |artist|
        artist.update_songs_release
      end
    end
  end
  
  desc "separate releases"
  task :separate_releases => :environment do
    Release.find_in_batches do |releases|
      releases.each do |release|
        release.separate_releases
      end
    end
  end
  
  desc "merge releases"
  task :merge_releases => :environment do
    Release.find_in_batches do |releases|
      releases.each do |release|
        release.merge_releases
      end
    end
  end
  
  desc "update artist's lang"
  task :artist_lang => :environment do
    Artist.find_in_batches do |artists|
      artists.each do |artist|
        puts "== ID: #{artist.id}, Name: #{artist.name}"
        if LanguageDetector.asian_language?(artist.name)
          artist.lang = "zh-TW"
          artist.save
          puts "zh-TW"
        end
      end
    end
  end
  
end