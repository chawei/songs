class AddSongIndex < ActiveRecord::Migration
  def self.up
    add_index :relationships, [:target_id, :source_type, :relationship_type, :target_type], :name => 'rel_participant'
  end

  def self.down
    remove_index :relationships, :name => 'rel_participant'
  end
end
