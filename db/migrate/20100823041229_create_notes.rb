class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.integer :lyric_id
      t.text :content
      t.integer :created_by_id

      t.timestamps
    end
  end

  def self.down
    drop_table :notes
  end
end
