require 'spec_helper'

describe Video do
  context "possible" do
    it "should return videos which similarity is not nil" do
      song           = Factory(:song)
      video_nil      = Factory(:video, :similarity => nil, :song => song)
      video_exact    = Factory(:video, :similarity => 'exact', :song => song)
      video_possible = Factory(:video, :similarity => 'possible', :song => song)
      video_first    = Factory(:video, :similarity => 'first_result', :song => song)
      
      videos = Video.possible
      videos.should include video_nil
      videos.should include video_exact
      videos.should include video_possible
      videos.should_not include video_first
    end
  end
  
  context "find_song_by_url" do
    it "should return the correct song based on the given url" do
    end
  end
  
  context 'parse_url' do
    it 'should extract uid and source from url' do
      url = "http://youtube.com/watch?v=EkHTsc9PU2A"
      video = Video.create(:url => url)
      video.source.should == 'youtube'
      video.uid.should == 'EkHTsc9PU2A'
    end
  end
end
