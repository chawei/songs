require 'spec_helper'

describe Song do
  context "set_performer and set_writer" do
    it "should create performer and writer based on performer_name and writer_name" do
      artist_name = "Awesome Artist"
      artist = Factory(:artist, :name => artist_name)
      song = Factory(:song, :performer_name => artist_name, :writer_name => artist_name)
      song.performers.should include artist
      song.writers.should include artist
      song.performer.should == artist
      song.writer.should == artist
    end
  end
  
  context 'performer' do
    it 'should return performer name' do
      artist_name = "Jason Mraz"
      song = Factory(:song, :performer_name => artist_name, :title => 'I am Yours')
      Artist.count.should == 1
      song.performer.name.should == 'Jason Mraz'
    end
  end
  
  context 'writer' do
    it 'should return writer name' do
      performer_name = "Jason Mraz"
      writer_name = "Jason Writer"
      song = Song.create(:performer_name => performer_name, :writer_name => writer_name, :title => 'I am Yours')
      Artist.count.should == 2
      song.writer.name.should == 'Jason Writer'
    end
  end
end