class Event < ActiveRecord::Base
  belongs_to :artist
  belongs_to :created_by, :class_name => "User", :foreign_key => 'created_by_id'
  belongs_to :updated_by, :class_name => "User", :foreign_key => 'updated_by_id'
  
  validates_presence_of :artist_id
end
