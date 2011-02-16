class CreateReleases < ActiveRecord::Migration
  def self.up
    create_table :releases do |t|
      t.string :release_type
      t.string :title
      t.date   :release_date
      t.string :small_image_url
      t.string :medium_image_url
      t.string :large_image_url
      t.string :mbid

      t.timestamps
    end
  end

  def self.down
    drop_table :releases
  end
end
