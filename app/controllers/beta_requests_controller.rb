class BetaRequestsController < ApplicationController
  before_filter :require_admin_user, :except => :create
  
  # GET /beta_requests
  # GET /beta_requests.xml
  def index
    @beta_requests = BetaRequest.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @beta_requests }
    end
  end

  # GET /beta_requests/1
  # GET /beta_requests/1.xml
  def show
    @beta_request = BetaRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @beta_request }
    end
  end

  # GET /beta_requests/new
  # GET /beta_requests/new.xml
  def new
    @beta_request = BetaRequest.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @beta_request }
    end
  end

  # GET /beta_requests/1/edit
  def edit
    @beta_request = BetaRequest.find(params[:id])
  end

  # POST /beta_requests
  # POST /beta_requests.xml
  def create
    @beta_request = BetaRequest.new(params[:beta_request])

    respond_to do |format|
      if @beta_request.save
        format.html { redirect_to(root_url, :notice => 'Beta request was successfully created.') }
        format.xml  { render :xml => @beta_request, :status => :created, :location => @beta_request }
        format.js   { render :json => { :message => 'ok' } }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @beta_request.errors, :status => :unprocessable_entity }
        format.js   { render :json => { :errors => @beta_request.errors.full_messages } }
      end
    end
  end

  # PUT /beta_requests/1
  # PUT /beta_requests/1.xml
  def update
    @beta_request = BetaRequest.find(params[:id])

    respond_to do |format|
      if @beta_request.update_attributes(params[:beta_request])
        format.html { redirect_to(@beta_request, :notice => 'Beta request was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @beta_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /beta_requests/1
  # DELETE /beta_requests/1.xml
  def destroy
    @beta_request = BetaRequest.find(params[:id])
    @beta_request.destroy

    respond_to do |format|
      format.html { redirect_to(beta_requests_url) }
      format.xml  { head :ok }
    end
  end
end
