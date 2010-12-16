require 'spec_helper'

describe "events/index.html.erb" do
  before(:each) do
    assign(:events, [
      stub_model(Event,
        :title => "Title",
        :url => "Url",
        :detail => "MyText"
      ),
      stub_model(Event,
        :title => "Title",
        :url => "Url",
        :detail => "MyText"
      )
    ])
  end

  it "renders a list of events" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
