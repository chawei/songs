namespace :update do
  desc "move video_url to video model"
  task :video => :environment do
    Song.all.each do |song|
      puts "== ID: #{song.id}, URL: #{song.video_url}"
      song.update_videos(song.video_url, song.created_by_id)
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
        puts "== ID: #{song.id}, Performer: #{song.performer_name}"
        song.title = Song.normalize_title(song.title)
        unless song.save
          song.destroy
        end
      end
    end
  end
  
end