require 'spec_helper'

describe QueueLinksController do

  def mock_queue_link(stubs={})
    (@mock_queue_link ||= mock_model(QueueLink).as_null_object).tap do |queue_link|
      queue_link.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all queue_links as @queue_links" do
      QueueLink.stub(:all) { [mock_queue_link] }
      get :index
      assigns(:queue_links).should eq([mock_queue_link])
    end
  end

  describe "GET show" do
    it "assigns the requested queue_link as @queue_link" do
      QueueLink.stub(:find).with("37") { mock_queue_link }
      get :show, :id => "37"
      assigns(:queue_link).should be(mock_queue_link)
    end
  end

  describe "GET new" do
    it "assigns a new queue_link as @queue_link" do
      QueueLink.stub(:new) { mock_queue_link }
      get :new
      assigns(:queue_link).should be(mock_queue_link)
    end
  end

  describe "GET edit" do
    it "assigns the requested queue_link as @queue_link" do
      QueueLink.stub(:find).with("37") { mock_queue_link }
      get :edit, :id => "37"
      assigns(:queue_link).should be(mock_queue_link)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created queue_link as @queue_link" do
        QueueLink.stub(:new).with({'these' => 'params'}) { mock_queue_link(:save => true) }
        post :create, :queue_link => {'these' => 'params'}
        assigns(:queue_link).should be(mock_queue_link)
      end

      it "redirects to the created queue_link" do
        QueueLink.stub(:new) { mock_queue_link(:save => true) }
        post :create, :queue_link => {}
        response.should redirect_to(queue_link_url(mock_queue_link))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved queue_link as @queue_link" do
        QueueLink.stub(:new).with({'these' => 'params'}) { mock_queue_link(:save => false) }
        post :create, :queue_link => {'these' => 'params'}
        assigns(:queue_link).should be(mock_queue_link)
      end

      it "re-renders the 'new' template" do
        QueueLink.stub(:new) { mock_queue_link(:save => false) }
        post :create, :queue_link => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested queue_link" do
        QueueLink.should_receive(:find).with("37") { mock_queue_link }
        mock_queue_link.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :queue_link => {'these' => 'params'}
      end

      it "assigns the requested queue_link as @queue_link" do
        QueueLink.stub(:find) { mock_queue_link(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:queue_link).should be(mock_queue_link)
      end

      it "redirects to the queue_link" do
        QueueLink.stub(:find) { mock_queue_link(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(queue_link_url(mock_queue_link))
      end
    end

    describe "with invalid params" do
      it "assigns the queue_link as @queue_link" do
        QueueLink.stub(:find) { mock_queue_link(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:queue_link).should be(mock_queue_link)
      end

      it "re-renders the 'edit' template" do
        QueueLink.stub(:find) { mock_queue_link(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested queue_link" do
      QueueLink.should_receive(:find).with("37") { mock_queue_link }
      mock_queue_link.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the queue_links list" do
      QueueLink.stub(:find) { mock_queue_link }
      delete :destroy, :id => "1"
      response.should redirect_to(queue_links_url)
    end
  end

end
