require 'spec_helper'

describe "beta_requests/show.html.erb" do
  before(:each) do
    @beta_request = assign(:beta_request, stub_model(BetaRequest,
      :email => "Email",
      :is_sent => false,
      :is_user => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
  end
end
