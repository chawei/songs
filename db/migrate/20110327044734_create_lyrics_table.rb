class CreateLyricsTable < ActiveRecord::Migration
  def self.up
    create_table :lyrics do |t|
      t.string :song_title
      t.string :song_performer_name
      t.text :content
      t.integer :song_id
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
  end

  def self.down
    drop_table :lyrics
  end
end
