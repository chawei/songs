require 'spec_helper'

describe "queue_links/show.html.erb" do
  before(:each) do
    @queue_link = assign(:queue_link, stub_model(QueueLink,
      :artist_url => "Artist Url",
      :artist_name => "Artist Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Artist Url/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Artist Name/)
  end
end
