require 'spec_helper'

describe "queue_links/new.html.erb" do
  before(:each) do
    assign(:queue_link, stub_model(QueueLink,
      :artist_url => "MyString",
      :artist_name => "MyString"
    ).as_new_record)
  end

  it "renders new queue_link form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => queue_links_path, :method => "post" do
      assert_select "input#queue_link_artist_url", :name => "queue_link[artist_url]"
      assert_select "input#queue_link_artist_name", :name => "queue_link[artist_name]"
    end
  end
end
