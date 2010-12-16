class QueueLinksController < ApplicationController
  # GET /queue_links
  # GET /queue_links.xml
  def index
    @queue_links = QueueLink.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @queue_links }
    end
  end

  # GET /queue_links/1
  # GET /queue_links/1.xml
  def show
    @queue_link = QueueLink.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @queue_link }
    end
  end

  # GET /queue_links/new
  # GET /queue_links/new.xml
  def new
    @queue_link = QueueLink.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @queue_link }
    end
  end

  # GET /queue_links/1/edit
  def edit
    @queue_link = QueueLink.find(params[:id])
  end

  # POST /queue_links
  # POST /queue_links.xml
  def create
    @queue_link = QueueLink.new(params[:queue_link])

    respond_to do |format|
      if @queue_link.save
        format.html { redirect_to(@queue_link, :notice => 'Queue link was successfully created.') }
        format.xml  { render :xml => @queue_link, :status => :created, :location => @queue_link }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @queue_link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /queue_links/1
  # PUT /queue_links/1.xml
  def update
    @queue_link = QueueLink.find(params[:id])

    respond_to do |format|
      if @queue_link.update_attributes(params[:queue_link])
        format.html { redirect_to(@queue_link, :notice => 'Queue link was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @queue_link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /queue_links/1
  # DELETE /queue_links/1.xml
  def destroy
    @queue_link = QueueLink.find(params[:id])
    @queue_link.destroy

    respond_to do |format|
      format.html { redirect_to(queue_links_url) }
      format.xml  { head :ok }
    end
  end
end
