namespace :import do
  desc "import artist's albums"
  task :artist_albums => :environment do
    QueueLink.unimported.each do |qlink|
      BoxImporter.import_artist_albums(qlink.artist_url, qlink.artist_name)
      qlink.imported = true
      qlink.save
    end
  end
end