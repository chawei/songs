require "spec_helper"

describe LyricsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/lyrics" }.should route_to(:controller => "lyrics", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/lyrics/new" }.should route_to(:controller => "lyrics", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/lyrics/1" }.should route_to(:controller => "lyrics", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/lyrics/1/edit" }.should route_to(:controller => "lyrics", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/lyrics" }.should route_to(:controller => "lyrics", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/lyrics/1" }.should route_to(:controller => "lyrics", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/lyrics/1" }.should route_to(:controller => "lyrics", :action => "destroy", :id => "1")
    end

  end
end
