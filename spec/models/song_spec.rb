require 'spec_helper'

describe Song do
  context 'performer' do
    it 'should return performer name' do
      artist_name = "Jason Mraz"
      song = Song.create(:performer_name => artist_name, :title => 'I am Yours')
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