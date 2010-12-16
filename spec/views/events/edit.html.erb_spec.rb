require 'spec_helper'

describe "events/edit.html.erb" do
  before(:each) do
    @event = assign(:event, stub_model(Event,
      :title => "MyString",
      :url => "MyString",
      :detail => "MyText"
    ))
  end

  it "renders the edit event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => event_path(@event), :method => "post" do
      assert_select "input#event_title", :name => "event[title]"
      assert_select "input#event_url", :name => "event[url]"
      assert_select "textarea#event_detail", :name => "event[detail]"
    end
  end
end
