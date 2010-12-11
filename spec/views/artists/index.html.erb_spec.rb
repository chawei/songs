require 'spec_helper'

describe "artists/index.html.erb" do
  before(:each) do
    assign(:artists, [
      stub_model(Artist,
        :name => "Name",
        :full_name => "Full Name",
        :artist_type => "Artist Type",
        :primary_position => "Primary Position",
        :secondary_position => "Secondary Position",
        :bio_summary => "MyText",
        :bio_full => "MyText",
        :image_small_url => "Image Small Url",
        :image_large_url => "Image Large Url"
      ),
      stub_model(Artist,
        :name => "Name",
        :full_name => "Full Name",
        :artist_type => "Artist Type",
        :primary_position => "Primary Position",
        :secondary_position => "Secondary Position",
        :bio_summary => "MyText",
        :bio_full => "MyText",
        :image_small_url => "Image Small Url",
        :image_large_url => "Image Large Url"
      )
    ])
  end

  it "renders a list of artists" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Full Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Artist Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Primary Position".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Secondary Position".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Image Small Url".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Image Large Url".to_s, :count => 2
  end
end
