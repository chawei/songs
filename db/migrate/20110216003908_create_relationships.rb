class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.references :source, :polymorphic => true
      t.references :target, :polymorphic => true
      t.timestamps
    end
  end

  def self.down
    drop_table :relationships
  end
end
