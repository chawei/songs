namespace :import do
  desc "import artist's albums"
  task :artist_albums => :environment do
    QueueLink.unimported[0..1].each do |qlink|
      # TODO: if artist_name not chinese but from taiwan
      if LanguageDetector.asian_language?(qlink.artist_name) || LastFm.from_taiwan?(qlink.artist_name)
        BoxImporter.import_artist(qlink.artist_name)
      else
        SongImporter.import_albums_by_artist_name(qlink.artist_name)
      end
      qlink.imported = true
      qlink.save
    end
  end
  
  desc "import artists and everything"
  task :artists => :environment do
    Artist.all.each do |artist|
      # TODO: if artist_name not chinese but from taiwan
      if artist.lang == "zh-TW"
        BoxImporter.import_artist(artist.name)
      else
        SongImporter.import_albums_by_artist_name(artist.name)
      end
      sleep(2)
    end
  end
end