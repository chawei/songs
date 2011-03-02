class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.integer :user_id
      t.string :query_url
      t.string :request_type
      t.boolean :resolved

      t.timestamps
    end
  end

  def self.down
    drop_table :requests
  end
end
