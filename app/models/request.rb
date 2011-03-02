class Request < ActiveRecord::Base
  default_scope :order => 'created_at DESC'
  
  belongs_to :requester, :class_name => "User", :foreign_key => 'user_id'
  after_initialize :set_values
  
  
  def resolve!
    self.resolved = true
    requests = Request.where(:query_url => self.query_url)
    requests.each do |r|
      r.resolved = true
      r.save
    end
    self.save
  end
  
  private
    def set_values
      self.resolved = false if self.resolved.nil?
    end
end
