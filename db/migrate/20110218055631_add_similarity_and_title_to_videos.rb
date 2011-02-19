class AddSimilarityAndTitleToVideos < ActiveRecord::Migration
  def self.up
    add_column :videos, :similarity, :string
    add_column :videos, :title, :string
  end

  def self.down
    remove_column :videos, :title
    remove_column :videos, :similarity
  end
end
