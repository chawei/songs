class CreateParticipations < ActiveRecord::Migration
  def self.up
    create_table :participations do |t|
      t.integer :artist_id
      t.integer :lyric_id
      t.string :participation_type

      t.timestamps
    end
  end

  def self.down
    drop_table :participations
  end
end
