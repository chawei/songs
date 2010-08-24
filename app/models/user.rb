class User < ActiveRecord::Base
  has_friendly_id :username, :use_slug => true
  
  acts_as_authentic do |c|
    c.merge_validates_length_of_login_field_options({:minimum => 4})
    #c.my_config_option = my_value # for available options see documentation in: Authlogic::ActsAsAuthentic
  end # block optional
  
  has_many :created_lyrics, :class_name => "Lyric", :foreign_key => "created_by_id"
  has_many :updated_lyrics, :class_name => "Lyric", :foreign_key => "updated_by_id"
  
  has_many :created_stories, :class_name => "BackgroundStory", :foreign_key => "created_by_id"
  has_many :updated_stories, :class_name => "BackgroundStory", :foreign_key => "updated_by_id"
  
  has_many :created_notes, :class_name => "Note", :foreign_key => "created_by_id"
  
  
  def own_story?(story)
    created_stories.include? story
  end
  
  def own_lyric?(lyric)
    created_lyrics.include? lyric
  end
  
  def own_note?(note)
    created_notes.include? note
  end
  
  def lyric_notes(lyric)
    notes = Note.find_all_by_lyric_id_and_created_by_id(lyric, self)
  end
end