require "spec_helper"

describe BetaRequestsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/beta_requests" }.should route_to(:controller => "beta_requests", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/beta_requests/new" }.should route_to(:controller => "beta_requests", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/beta_requests/1" }.should route_to(:controller => "beta_requests", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/beta_requests/1/edit" }.should route_to(:controller => "beta_requests", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/beta_requests" }.should route_to(:controller => "beta_requests", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/beta_requests/1" }.should route_to(:controller => "beta_requests", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/beta_requests/1" }.should route_to(:controller => "beta_requests", :action => "destroy", :id => "1")
    end

  end
end
