class AddVideoUrlToLyrics < ActiveRecord::Migration
  def self.up
    add_column :lyrics, :video_url, :string
  end

  def self.down
    remove_column :lyrics, :video_url
  end
end
