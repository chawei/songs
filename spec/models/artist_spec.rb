require 'spec_helper'

describe Artist do
  context "set_full_name" do
    it "should set full_name based on name" do
      artist_name = "Jason Mraz"
      artist = Factory(:artist, :name => artist_name)
      artist.full_name.should == artist_name
    end
  end
  
end
