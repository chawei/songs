class ChangePerformerToPerformerNameInLyrics < ActiveRecord::Migration
  def self.up
    rename_column :lyrics, :performer, :performer_name
    rename_column :lyrics, :writer, :writer_name
  end

  def self.down
    rename_column :lyrics, :performer_name, :performer
    rename_column :lyrics, :writer_name, :writer
  end
end
