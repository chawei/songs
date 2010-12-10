require 'spec_helper'

describe Video do
  context 'parse_url' do
    it 'should extract uid and source from url' do
      url = "http://youtube.com/watch?v=EkHTsc9PU2A"
      video = Video.create(:url => url)
      video.source.should == 'youtube'
      video.uid.should == 'EkHTsc9PU2A'
    end
  end
end
