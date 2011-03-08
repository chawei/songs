SimpleNavigation::Configuration.run do |navigation|
  navigation.id_generator = Proc.new {|key| "menu-#{key}"}
  navigation.items do |primary|
    primary.item :home, 'home', root_path
    #primary.item :notes, 'NOTES', notes_path, :highlights_on => /\/notes/
    primary.item :songs, 'songs', songs_path, :highlights_on => /\/songs/, :if => Proc.new { current_user }
    primary.item :account, 'profile', account_path, :highlights_on => /\/account/, :if => Proc.new { current_user }
    primary.item :who_to_follow, 'who to follow', who_to_follow_path, :if => Proc.new { current_user }
  end
end