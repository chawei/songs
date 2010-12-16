require "spec_helper"

describe QueueLinksController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/queue_links" }.should route_to(:controller => "queue_links", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/queue_links/new" }.should route_to(:controller => "queue_links", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/queue_links/1" }.should route_to(:controller => "queue_links", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/queue_links/1/edit" }.should route_to(:controller => "queue_links", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/queue_links" }.should route_to(:controller => "queue_links", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/queue_links/1" }.should route_to(:controller => "queue_links", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/queue_links/1" }.should route_to(:controller => "queue_links", :action => "destroy", :id => "1")
    end

  end
end
