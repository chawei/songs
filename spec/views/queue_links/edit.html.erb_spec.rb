require 'spec_helper'

describe "queue_links/edit.html.erb" do
  before(:each) do
    @queue_link = assign(:queue_link, stub_model(QueueLink,
      :artist_url => "MyString",
      :artist_name => "MyString"
    ))
  end

  it "renders the edit queue_link form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => queue_link_path(@queue_link), :method => "post" do
      assert_select "input#queue_link_artist_url", :name => "queue_link[artist_url]"
      assert_select "input#queue_link_artist_name", :name => "queue_link[artist_name]"
    end
  end
end
