require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe BetaRequestsController do

  def mock_beta_request(stubs={})
    @mock_beta_request ||= mock_model(BetaRequest, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all beta_requests as @beta_requests" do
      BetaRequest.stub(:all) { [mock_beta_request] }
      get :index
      assigns(:beta_requests).should eq([mock_beta_request])
    end
  end

  describe "GET show" do
    it "assigns the requested beta_request as @beta_request" do
      BetaRequest.stub(:find).with("37") { mock_beta_request }
      get :show, :id => "37"
      assigns(:beta_request).should be(mock_beta_request)
    end
  end

  describe "GET new" do
    it "assigns a new beta_request as @beta_request" do
      BetaRequest.stub(:new) { mock_beta_request }
      get :new
      assigns(:beta_request).should be(mock_beta_request)
    end
  end

  describe "GET edit" do
    it "assigns the requested beta_request as @beta_request" do
      BetaRequest.stub(:find).with("37") { mock_beta_request }
      get :edit, :id => "37"
      assigns(:beta_request).should be(mock_beta_request)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created beta_request as @beta_request" do
        BetaRequest.stub(:new).with({'these' => 'params'}) { mock_beta_request(:save => true) }
        post :create, :beta_request => {'these' => 'params'}
        assigns(:beta_request).should be(mock_beta_request)
      end

      it "redirects to the created beta_request" do
        BetaRequest.stub(:new) { mock_beta_request(:save => true) }
        post :create, :beta_request => {}
        response.should redirect_to(beta_request_url(mock_beta_request))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved beta_request as @beta_request" do
        BetaRequest.stub(:new).with({'these' => 'params'}) { mock_beta_request(:save => false) }
        post :create, :beta_request => {'these' => 'params'}
        assigns(:beta_request).should be(mock_beta_request)
      end

      it "re-renders the 'new' template" do
        BetaRequest.stub(:new) { mock_beta_request(:save => false) }
        post :create, :beta_request => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested beta_request" do
        BetaRequest.stub(:find).with("37") { mock_beta_request }
        mock_beta_request.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :beta_request => {'these' => 'params'}
      end

      it "assigns the requested beta_request as @beta_request" do
        BetaRequest.stub(:find) { mock_beta_request(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:beta_request).should be(mock_beta_request)
      end

      it "redirects to the beta_request" do
        BetaRequest.stub(:find) { mock_beta_request(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(beta_request_url(mock_beta_request))
      end
    end

    describe "with invalid params" do
      it "assigns the beta_request as @beta_request" do
        BetaRequest.stub(:find) { mock_beta_request(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:beta_request).should be(mock_beta_request)
      end

      it "re-renders the 'edit' template" do
        BetaRequest.stub(:find) { mock_beta_request(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested beta_request" do
      BetaRequest.stub(:find).with("37") { mock_beta_request }
      mock_beta_request.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the beta_requests list" do
      BetaRequest.stub(:find) { mock_beta_request }
      delete :destroy, :id => "1"
      response.should redirect_to(beta_requests_url)
    end
  end

end
