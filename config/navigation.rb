SimpleNavigation::Configuration.run do |navigation|
  navigation.id_generator = Proc.new {|key| "menu-#{key}"}
  navigation.items do |primary|
    primary.item :home, 'HOME', root_path
    #primary.item :notes, 'NOTES', notes_path, :highlights_on => /\/notes/
    primary.item :songs, 'SONGS', songs_path, :highlights_on => /\/songs/
    primary.item :account, 'MY STUFFS', account_path, :highlights_on => /\/account/
  end
end