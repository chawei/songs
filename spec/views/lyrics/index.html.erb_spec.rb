require 'spec_helper'

describe "lyrics/index.html.erb" do
  before(:each) do
    assign(:lyrics, [
      stub_model(Lyric,
        :song_title => "Song Title",
        :song_performer_name => "Song Performer Name",
        :content => "MyText",
        :song_id => 1,
        :created_by_id => 1,
        :updated_by_id => 1
      ),
      stub_model(Lyric,
        :song_title => "Song Title",
        :song_performer_name => "Song Performer Name",
        :content => "MyText",
        :song_id => 1,
        :created_by_id => 1,
        :updated_by_id => 1
      )
    ])
  end

  it "renders a list of lyrics" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Song Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Song Performer Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
