class AddCoverUrlToLyrics < ActiveRecord::Migration
  def self.up
    add_column :lyrics, :cover_url, :string
  end

  def self.down
    remove_column :lyrics, :cover_url
  end
end
