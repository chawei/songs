class CreateLyrics < ActiveRecord::Migration
  def self.up
    create_table :lyrics do |t|
      t.string :title
      t.string :performer
      t.string :writer
      t.text :content
      t.string :album_name
      t.integer :year
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
  end

  def self.down
    drop_table :lyrics
  end
end
