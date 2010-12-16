class CreateQueueLinks < ActiveRecord::Migration
  def self.up
    create_table :queue_links do |t|
      t.string  :artist_url
      t.string  :artist_name
      t.boolean :imported

      t.timestamps
    end
  end

  def self.down
    drop_table :queue_links
  end
end
