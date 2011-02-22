require 'spec_helper'

describe Release do
  
  context "separate_releases" do 
    it "should separate releases correctly if there is | symbol" do
      artist  = Factory(:artist)
      release = Factory(:release, :title => "Album A | Album B | Album C")
      songs   = [Factory(:song), Factory(:song)]
      
      artist.releases << release
      release.songs << songs
      
      release.separate_releases
      
      artist.releases.count.should == 3
      artist.releases[0].songs.should == songs
      artist.releases[1].songs.should == songs
      artist.releases[2].songs.should == songs
      
      artist.releases.where(:title => 'Album A')[0].should == release
      artist.releases.where(:title => 'Album B')[0].title.should == "Album B"
      artist.releases.where(:title => 'Album C')[0].title.should == "Album C"
    end
  end
end
