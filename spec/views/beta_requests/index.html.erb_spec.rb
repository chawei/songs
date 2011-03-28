require 'spec_helper'

describe "beta_requests/index.html.erb" do
  before(:each) do
    assign(:beta_requests, [
      stub_model(BetaRequest,
        :email => "Email",
        :is_sent => false,
        :is_user => false
      ),
      stub_model(BetaRequest,
        :email => "Email",
        :is_sent => false,
        :is_user => false
      )
    ])
  end

  it "renders a list of beta_requests" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
