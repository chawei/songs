require 'spec_helper'

describe "artists/show.html.erb" do
  before(:each) do
    @artist = assign(:artist, stub_model(Artist,
      :name => "Name",
      :full_name => "Full Name",
      :artist_type => "Artist Type",
      :primary_position => "Primary Position",
      :secondary_position => "Secondary Position",
      :bio_summary => "MyText",
      :bio_full => "MyText",
      :image_small_url => "Image Small Url",
      :image_large_url => "Image Large Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Full Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Artist Type/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Primary Position/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Secondary Position/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Image Small Url/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Image Large Url/)
  end
end
