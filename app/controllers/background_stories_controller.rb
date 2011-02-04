class BackgroundStoriesController < ApplicationController
  before_filter :require_user, :except => [:index, :show]
  before_filter :find_song, :only => [:new, :show, :edit]
  
  # GET /background_stories
  # GET /background_stories.xml
  def index
    @background_stories = BackgroundStory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @background_stories }
    end
  end

  # GET /background_stories/1
  # GET /background_stories/1.xml
  def show
    @background_story = BackgroundStory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @background_story }
    end
  end

  # GET /background_stories/new
  # GET /background_stories/new.xml
  def new
    @background_story = @song.background_stories.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @background_story }
    end
  end

  # GET /background_stories/1/edit
  def edit
    @background_story = BackgroundStory.find(params[:id])
    respond_to do |format|
      format.html { render :action => :new }
      format.js   { render :layout => false }
    end
  end

  # POST /background_stories
  # POST /background_stories.xml
  def create
    @background_story = BackgroundStory.new(params[:background_story])
    @background_story.created_by = current_user
    @background_story.updated_by = current_user

    respond_to do |format|
      if @background_story.save
        format.html { redirect_to(@background_story.song, :notice => 'Background story was successfully created.') }
        format.js   { render :layout => false }
        format.xml  { render :xml => @background_story, :status => :created, :location => @background_story }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @background_story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /background_stories/1
  # PUT /background_stories/1.xml
  def update
    @background_story = BackgroundStory.find(params[:id])
    params[:background_story][:updated_by_id] = current_user.id

    respond_to do |format|
      if @background_story.update_attributes(params[:background_story])
        format.html { redirect_to(@background_story.song, :notice => 'Background story was successfully updated.') }
        format.js   { render :layout => false }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @background_story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /background_stories/1
  # DELETE /background_stories/1.xml
  def destroy
    @background_story = BackgroundStory.find(params[:id])
    @background_story_id = @background_story.id
    @song = @background_story.song
    @background_story.destroy

    respond_to do |format|
      format.html { redirect_to(@song) }
      format.js   { render :layout => false }
      format.xml  { head :ok }
    end
  end
  
  private
    def find_song
      @song = Song.find(params[:song_id])
    end
end
