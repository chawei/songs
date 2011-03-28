require 'spec_helper'

describe "lyrics/edit.html.erb" do
  before(:each) do
    @lyric = assign(:lyric, stub_model(Lyric,
      :song_title => "MyString",
      :song_performer_name => "MyString",
      :content => "MyText",
      :song_id => 1,
      :created_by_id => 1,
      :updated_by_id => 1
    ))
  end

  it "renders the edit lyric form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => lyrics_path(@lyric), :method => "post" do
      assert_select "input#lyric_song_title", :name => "lyric[song_title]"
      assert_select "input#lyric_song_performer_name", :name => "lyric[song_performer_name]"
      assert_select "textarea#lyric_content", :name => "lyric[content]"
      assert_select "input#lyric_song_id", :name => "lyric[song_id]"
      assert_select "input#lyric_created_by_id", :name => "lyric[created_by_id]"
      assert_select "input#lyric_updated_by_id", :name => "lyric[updated_by_id]"
    end
  end
end
