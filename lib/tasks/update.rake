namespace :update do
  desc "move video_url to video model"
  task :video => :environment do
    Lyric.all.each do |lyric|
      puts "== ID: #{lyric.id}, URL: #{lyric.video_url}"
      lyric.update_videos(lyric.video_url, lyric.created_by_id)
      #print('.')
    end
  end
end