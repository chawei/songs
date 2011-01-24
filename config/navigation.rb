SimpleNavigation::Configuration.run do |navigation|
  navigation.id_generator = Proc.new {|key| "menu-#{key}"}
  navigation.items do |primary|
    primary.item :home, 'HOME', root_path
    #primary.item :notes, 'NOTES', notes_path, :highlights_on => /\/notes/
    primary.item :lyrics, 'SONGS', lyrics_path, :highlights_on => /\/lyrics/
    primary.item :account, 'MY STUFFS', account_path, :highlights_on => /\/account/
  end
end