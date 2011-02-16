class AddMbidToArtists < ActiveRecord::Migration
  def self.up
    add_column :artists, :mbid, :string
  end

  def self.down
    remove_column :artists, :mbid
  end
end
