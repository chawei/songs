SimpleNavigation::Configuration.run do |navigation|
  navigation.id_generator = Proc.new {|key| "menu-#{key}"}
  navigation.items do |primary|
    primary.item :home, 'home', root_path
    #primary.item :notes, 'NOTES', notes_path, :highlights_on => /\/notes/
    primary.item :songs, 'songs', songs_path, :highlights_on => /\/songs/
    primary.item :account, 'profile', account_path, :highlights_on => /\/account/
  end
end