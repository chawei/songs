class Note < ActiveRecord::Base
  belongs_to :created_by, :class_name => "User", :foreign_key => 'created_by_id'
  
  belongs_to :song
end
