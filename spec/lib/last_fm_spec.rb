# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe LastFm do
  context "get_artist_info" do
    it "should return artist lang with given artist name" do
      LastFm.should_receive(:get_artist_info).with('jack johnson').and_return(Crack::XML.parse(File.read('spec/fixtures/get_artist_info.xml')))
      res = LastFm.get_artist_info('jack johnson')
      res["lfm"]["artist"]["image"][1].should == "http://userserve-ak.last.fm/serve/64/53737.jpg"
    end
  end
end