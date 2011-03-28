class CreateBetaRequests < ActiveRecord::Migration
  def self.up
    create_table :beta_requests do |t|
      t.string :email
      t.boolean :is_sent
      t.datetime :sent_at
      t.boolean :is_user

      t.timestamps
    end
  end

  def self.down
    drop_table :beta_requests
  end
end
