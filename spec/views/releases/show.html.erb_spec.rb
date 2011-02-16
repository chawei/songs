require 'spec_helper'

describe "releases/show.html.erb" do
  before(:each) do
    @release = assign(:release, stub_model(Release,
      :release_type => "Release Type",
      :title => "Title",
      :small_image_url => "Small Image Url",
      :medium_image_url => "Medium Image Url",
      :large_image_url => "Large Image Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Release Type/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Small Image Url/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Medium Image Url/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Large Image Url/)
  end
end
