class AddLyricsLastUpdatedToSongs < ActiveRecord::Migration
  def self.up
    add_column :songs, :lyrics_last_updated, :datetime
  end

  def self.down
    remove_column :songs, :lyrics_last_updated
  end
end
