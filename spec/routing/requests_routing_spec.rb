require "spec_helper"

describe RequestsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/requests" }.should route_to(:controller => "requests", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/requests/new" }.should route_to(:controller => "requests", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/requests/1" }.should route_to(:controller => "requests", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/requests/1/edit" }.should route_to(:controller => "requests", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/requests" }.should route_to(:controller => "requests", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/requests/1" }.should route_to(:controller => "requests", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/requests/1" }.should route_to(:controller => "requests", :action => "destroy", :id => "1")
    end

  end
end
