class User < ActiveRecord::Base
  has_friendly_id :username, :use_slug => true
  
  acts_as_followable
  acts_as_follower
  
  attr_accessor :password_confirmation
  has_many :authorizations, :dependent => :destroy
  has_many :requests
  
  acts_as_authentic do |c|
    # c.merge_validates_length_of_login_field_options({:minimum => 4})
    c.ignore_blank_passwords = true #ignoring passwords
    c.validate_password_field = false #ignoring validations for password fields
    c.perishable_token_valid_for = 2.hours
  end
  
  #here we add required validations for a new record and pre-existing record
  validate do |user|
    if user.new_record? #adds validation if it is a new record
      user.errors.add(:password, "is required") if user.password.blank? 
      user.errors.add(:password_confirmation, "is required") if user.password_confirmation.blank?
      user.errors.add(:password, "Password and confirmation must match") if user.password != user.password_confirmation
    elsif !(!user.new_record? && user.password.blank? && user.password_confirmation.blank?) #adds validation only if password or password_confirmation are modified
      user.errors.add(:password, "is required") if user.password.blank?
      user.errors.add(:password_confirmation, "is required") if user.password_confirmation.blank?
      user.errors.add(:password, " and confirmation must match.") if user.password != user.password_confirmation
      user.errors.add(:password, " and confirmation should be atleast 4 characters long.") if user.password.length < 4 || user.password_confirmation.length < 4
    end
  end
  
  acts_as_voter
  
  has_many :created_songs, :class_name => "Song", :foreign_key => "created_by_id"
  has_many :updated_songs, :class_name => "Song", :foreign_key => "updated_by_id"
  
  has_many :created_stories, :class_name => "BackgroundStory", :foreign_key => "created_by_id"
  has_many :updated_stories, :class_name => "BackgroundStory", :foreign_key => "updated_by_id"
  
  has_many :created_notes, :class_name => "Note", :foreign_key => "created_by_id"
  
  has_many :created_events, :class_name => "Event", :foreign_key => "created_by_id"
  has_many :updated_events, :class_name => "Event", :foreign_key => "updated_by_id"
  
  def normalize_friendly_id(text)
    text
  end
  
  def own_story?(story)
    created_stories.include? story
  end
  
  def own_song?(song)
    created_songs.include? song
  end
  
  def own_note?(note)
    created_notes.include? note
  end
  
  def own_event?(event)
    created_events.include? event
  end
  
  def song_notes(song)
    notes = Note.find_all_by_song_id_and_created_by_id(song, self)
  end
  
  def voted_for_songs
    Vote.where(:voter_id => id, :voteable_type => "Song", :vote => true).order('created_at DESC').map(&:voteable)
  end
  
  def following_feeds
    voter_ids = self.following_users.collect { |u| u.id }
    return Vote.following_feeds(voter_ids)
  end
  
  def suggested_users_to_follow
    user_ids = following_users.map { |f| f.id }
    user_ids << id
    User.where("id NOT IN (?)", user_ids).limit(10)
  end
  
  def self.create_from_hash(hash)
    #if hash['provider']
    #debugger
    username = hash['user_info']['nickname'] || hash['user_info']['name'].downcase.gsub(/\s/, '-')
    user = User.new(:username => username, :email => hash['extra']['user_hash']['email'], :name => hash['user_info']['name'])
    user.save(:validate => false) #create the user without performing validations. This is because most of the fields are not set.
    user.reset_persistence_token! #set persistence_token else sessions will not be created
    user
  end
end