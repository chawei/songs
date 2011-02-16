require 'spec_helper'

describe "releases/index.html.erb" do
  before(:each) do
    assign(:releases, [
      stub_model(Release,
        :release_type => "Release Type",
        :title => "Title",
        :small_image_url => "Small Image Url",
        :medium_image_url => "Medium Image Url",
        :large_image_url => "Large Image Url"
      ),
      stub_model(Release,
        :release_type => "Release Type",
        :title => "Title",
        :small_image_url => "Small Image Url",
        :medium_image_url => "Medium Image Url",
        :large_image_url => "Large Image Url"
      )
    ])
  end

  it "renders a list of releases" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Release Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Small Image Url".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Medium Image Url".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Large Image Url".to_s, :count => 2
  end
end
