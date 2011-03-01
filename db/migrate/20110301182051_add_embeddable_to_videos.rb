class AddEmbeddableToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :embeddable, :boolean
  end

  def self.down
    remove_column :videos, :embeddable
  end
end
