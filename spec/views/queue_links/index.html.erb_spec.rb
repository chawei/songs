require 'spec_helper'

describe "queue_links/index.html.erb" do
  before(:each) do
    assign(:queue_links, [
      stub_model(QueueLink,
        :artist_url => "Artist Url",
        :artist_name => "Artist Name"
      ),
      stub_model(QueueLink,
        :artist_url => "Artist Url",
        :artist_name => "Artist Name"
      )
    ])
  end

  it "renders a list of queue_links" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Artist Url".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Artist Name".to_s, :count => 2
  end
end
