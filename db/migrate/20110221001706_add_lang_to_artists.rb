class AddLangToArtists < ActiveRecord::Migration
  def self.up
    add_column :artists, :lang, :string
  end

  def self.down
    remove_column :artists, :lang
  end
end
