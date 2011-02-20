class Relationship < ActiveRecord::Base
  belongs_to :source, :polymorphic => true
  belongs_to :target, :polymorphic => true
  
  validates_uniqueness_of :source_id, :scope => [:source_type, :target_id, :target_type, :relationship_type]
  validates_presence_of :source_id, :target_id, :source_type, :target_type

end