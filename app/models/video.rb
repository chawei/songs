class Video < ActiveRecord::Base
  belongs_to :created_by, :class_name => "User", :foreign_key => 'created_by_id'
  belongs_to :lyric
  
  validates_uniqueness_of :uid, :scope => :source
  before_validation :parse_url
  
  def self.get_lyric(url)
    uri = URI(url)
    if uri.host =~ /youtube/
      uid = url.match(/[\?|\&]v=([\w_-]*)/)[1]
      source = 'youtube'
    end
    if video = self.find_by_uid_and_source(uid, source)
      return video.lyric
    else
      return nil
    end
  end
  
  protected
  
    def parse_url
      begin
        uri = URI(self.url)
        if uri.host =~ /youtube/
          uid = self.url.match(/\?v=([\w_-]*)/)[1]
          source = 'youtube'
        end
        self.uid = uid
        self.source = source
      rescue => e
        puts "=== URL: #{self.url}"
        puts e.message
      end
    end
end
