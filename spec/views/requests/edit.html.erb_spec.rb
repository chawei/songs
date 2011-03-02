require 'spec_helper'

describe "requests/edit.html.erb" do
  before(:each) do
    @request = assign(:request, stub_model(Request,
      :user_id => 1,
      :query_url => "MyString",
      :request_type => "MyString",
      :resolved => false
    ))
  end

  it "renders the edit request form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => request_path(@request), :method => "post" do
      assert_select "input#request_user_id", :name => "request[user_id]"
      assert_select "input#request_query_url", :name => "request[query_url]"
      assert_select "input#request_request_type", :name => "request[request_type]"
      assert_select "input#request_resolved", :name => "request[resolved]"
    end
  end
end
