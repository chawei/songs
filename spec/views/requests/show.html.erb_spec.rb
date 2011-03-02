require 'spec_helper'

describe "requests/show.html.erb" do
  before(:each) do
    @request = assign(:request, stub_model(Request,
      :user_id => 1,
      :query_url => "Query Url",
      :request_type => "Request Type",
      :resolved => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Query Url/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Request Type/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
  end
end
