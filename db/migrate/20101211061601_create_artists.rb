class CreateArtists < ActiveRecord::Migration
  def self.up
    create_table :artists do |t|
      t.string :name
      t.string :full_name
      t.string :artist_type
      t.string :primary_position
      t.string :secondary_position
      t.text :bio_summary
      t.text :bio_full
      t.string :image_small_url
      t.string :image_large_url

      t.timestamps
    end
  end

  def self.down
    drop_table :artists
  end
end
