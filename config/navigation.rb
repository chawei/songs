SimpleNavigation::Configuration.run do |navigation|
  navigation.id_generator = Proc.new {|key| "menu-#{key}"}
  navigation.items do |primary|
    primary.item :home, 'HOME', root_path
    primary.item :lyrics, 'LYRICS', lyrics_path, :highlights_on => /\/lyrics/
  end
end