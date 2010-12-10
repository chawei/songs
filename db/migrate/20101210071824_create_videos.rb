class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string  :uid
      t.string  :url
      t.string  :source
      t.integer :lyric_id
      t.integer :created_by_id

      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
