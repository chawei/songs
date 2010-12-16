class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.string :url
      t.datetime :start_time
      t.datetime :end_time
      t.text :detail
      t.integer :artist_id
      t.integer :created_by_id
      t.integer :updated_by_id

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
