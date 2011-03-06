class Video < ActiveRecord::Base
  belongs_to :created_by, :class_name => "User", :foreign_key => 'created_by_id'
  belongs_to :song
  
  validates_presence_of :uid, :url, :song_id
  validates_uniqueness_of :uid, :scope => [:source, :song_id]
  before_validation :parse_url
  before_create :set_values
  
  scope :possible, where("similarity IS NULL OR similarity = 'exact' OR similarity = 'possible'") 
  scope :exact, where(:similarity => 'exact')
  scope :embeddable, where(:embeddable => true)
  
  def self.find_song_by_url(url)
    uri = URI(url)
    if uri.host =~ /youtube/
      uid = url.match(/[\?|\&]v=([\w_-]*)/)[1]
      source = 'youtube'
    end
    videos = self.where(:uid => uid, :source => source, :similarity => 'exact')
    return videos[0].try(:song)
  end
  
  protected
  
    def parse_url
      begin
        uri = URI(self.url)
        if uri.host =~ /youtube/
          uid = self.url.match(/[\?|\&]v=([\w_-]*)/)[1]
          source = 'youtube'
        end
        self.uid = uid
        self.source = source
      rescue => e
        puts "=== URL: #{self.url}"
        puts e.message
      end
    end
    
    def set_values
      if self.source == 'youtube'
        client = YouTubeIt::Client.new
        result = client.video_by(self.uid)
        self.title = result.title
        self.embeddable = result.embeddable?
      end
    end
end
