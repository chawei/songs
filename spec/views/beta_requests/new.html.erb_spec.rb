require 'spec_helper'

describe "beta_requests/new.html.erb" do
  before(:each) do
    assign(:beta_request, stub_model(BetaRequest,
      :email => "MyString",
      :is_sent => false,
      :is_user => false
    ).as_new_record)
  end

  it "renders new beta_request form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => beta_requests_path, :method => "post" do
      assert_select "input#beta_request_email", :name => "beta_request[email]"
      assert_select "input#beta_request_is_sent", :name => "beta_request[is_sent]"
      assert_select "input#beta_request_is_user", :name => "beta_request[is_user]"
    end
  end
end
