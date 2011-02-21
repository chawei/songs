require 'spec_helper'

describe Artist do
  context "set_full_name" do
    it "should set full_name based on name" do
      artist_name = "Jason Mraz"
      artist = Factory(:artist, :name => artist_name)
      artist.full_name.should == artist_name
    end
  end
  
  context "update_songs_release" do
    it "should update release correctly" do
      song1 = Factory(:song, :title => "Track 1", :album_name => 'Album 1')
      song2 = Factory(:song, :title => "Track 2", :album_name => nil)
      song3 = Factory(:song, :title => "Track 3", :album_name => 'Main Release ')
      
      artist = Factory(:artist)
      existing_release = Factory(:release, :title => "Main Release")
      existing_release.artists << artist
      existing_release.songs << song3
      
      artist.performed_songs << [song1, song2]
      artist.releases.should == [existing_release]
      artist.update_songs_release
      
      artist.releases.count.should == 3
      artist.releases.should include song1.main_release
      artist.releases.should include song2.main_release
      artist.releases.should include song3.main_release
      song1.main_release.title.should == 'Album 1'
      song2.main_release.title.should == 'Unknown'
      song3.main_release.should == existing_release
    end
  end
  
end
