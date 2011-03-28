require 'spec_helper'

describe "lyrics/show.html.erb" do
  before(:each) do
    @lyric = assign(:lyric, stub_model(Lyric,
      :song_title => "Song Title",
      :song_performer_name => "Song Performer Name",
      :content => "MyText",
      :song_id => 1,
      :created_by_id => 1,
      :updated_by_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Song Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Song Performer Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
