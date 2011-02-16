require 'spec_helper'

describe "releases/edit.html.erb" do
  before(:each) do
    @release = assign(:release, stub_model(Release,
      :release_type => "MyString",
      :title => "MyString",
      :small_image_url => "MyString",
      :medium_image_url => "MyString",
      :large_image_url => "MyString"
    ))
  end

  it "renders the edit release form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => release_path(@release), :method => "post" do
      assert_select "input#release_release_type", :name => "release[release_type]"
      assert_select "input#release_title", :name => "release[title]"
      assert_select "input#release_small_image_url", :name => "release[small_image_url]"
      assert_select "input#release_medium_image_url", :name => "release[medium_image_url]"
      assert_select "input#release_large_image_url", :name => "release[large_image_url]"
    end
  end
end
