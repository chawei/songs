class CreateBackgroundStories < ActiveRecord::Migration
  def self.up
    create_table :background_stories do |t|
      t.integer :lyric_id
      t.string :title
      t.text :content
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
  end

  def self.down
    drop_table :background_stories
  end
end
