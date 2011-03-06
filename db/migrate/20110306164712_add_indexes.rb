class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :authorizations, :user_id
    add_index :notes, :song_id
    add_index :notes, :created_by_id
    add_index :videos, :song_id
    add_index :relationships, [:source_type, :source_id, :relationship_type]
    add_index :relationships, [:target_id, :target_type, :relationship_type]
  end

  def self.down
    remove_index :authorizations, :user_id
    remove_index :notes, :song_id
    remove_index :notes, :created_by_id
    remove_index :videos, :song_id
    remove_index :relationships, [:source_type, :source_id, :relationship_type]
    remove_index :relationships, [:target_id, :target_type, :relationship_type]
  end
end
