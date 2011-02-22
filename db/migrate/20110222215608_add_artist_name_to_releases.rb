class AddArtistNameToReleases < ActiveRecord::Migration
  def self.up
    add_column :releases, :artist_name, :string
  end

  def self.down
    remove_column :releases, :artist_name
  end
end
