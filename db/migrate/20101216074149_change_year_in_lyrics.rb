class ChangeYearInLyrics < ActiveRecord::Migration
  def self.up
    change_column :lyrics, :year, :string
  end

  def self.down
    change_column :lyrics, :year, :integer
  end
end
