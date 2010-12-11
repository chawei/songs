namespace :update do
  desc "move video_url to video model"
  task :video => :environment do
    Lyric.all.each do |lyric|
      puts "== ID: #{lyric.id}, URL: #{lyric.video_url}"
      lyric.update_videos(lyric.video_url, lyric.created_by_id)
    end
  end
  
  task :artist => :environment do
    Lyric.all.each do |lyric|
      puts "== ID: #{lyric.id}, Performer: #{lyric.performer_name}"
      ['performer', 'writer'].each do |artist_type|
        artist_name = lyric.send("#{artist_type}_name")
        unless artist_name.blank?
          artist = nil
          unless artist = Artist.find_by_name(artist_name)
            artist = Artist.create(:name => artist_name, :full_name => artist_name)
          end
          Participation.create(:artist_id => artist.id, :lyric_id => lyric.id, :participation_type => artist_type)
        end
      end
    end
  end
end