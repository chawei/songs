require 'spec_helper'

describe Release do
  
  context "separate_releases" do 
    it "should separate releases correctly if there is | symbol" do
      artist    = Factory(:artist)
      release_a = Factory(:release, :title => "Album A | Album B | Album C")
      release_b = Factory(:release, :title => "Album B | Album C")
      songs_a   = [Factory(:song), Factory(:song)]
      songs_b   = [Factory(:song), Factory(:song)]
      
      artist.releases << [release_a, release_b]
      release_a.songs << songs_a
      release_b.songs << songs_b
      
      release_a.separate_releases
      release_b.separate_releases
      
      artist.releases.count.should == 3
      artist.releases[0].songs.should == songs_a
      artist.releases[1].songs.should == (songs_a + songs_b)
      artist.releases[2].songs.should == (songs_a + songs_b)
      
      artist.releases.where(:title => 'Album A')[0].title.should == "Album A"
      artist.releases.where(:title => 'Album B')[0].title.should == "Album B"
      artist.releases.where(:title => 'Album C')[0].title.should == "Album C"
    end
  end
end
