require 'spec_helper'

describe "artists/edit.html.erb" do
  before(:each) do
    @artist = assign(:artist, stub_model(Artist,
      :name => "MyString",
      :full_name => "MyString",
      :artist_type => "MyString",
      :primary_position => "MyString",
      :secondary_position => "MyString",
      :bio_summary => "MyText",
      :bio_full => "MyText",
      :image_small_url => "MyString",
      :image_large_url => "MyString"
    ))
  end

  it "renders the edit artist form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => artist_path(@artist), :method => "post" do
      assert_select "input#artist_name", :name => "artist[name]"
      assert_select "input#artist_full_name", :name => "artist[full_name]"
      assert_select "input#artist_artist_type", :name => "artist[artist_type]"
      assert_select "input#artist_primary_position", :name => "artist[primary_position]"
      assert_select "input#artist_secondary_position", :name => "artist[secondary_position]"
      assert_select "textarea#artist_bio_summary", :name => "artist[bio_summary]"
      assert_select "textarea#artist_bio_full", :name => "artist[bio_full]"
      assert_select "input#artist_image_small_url", :name => "artist[image_small_url]"
      assert_select "input#artist_image_large_url", :name => "artist[image_large_url]"
    end
  end
end
