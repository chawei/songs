class LyricsController < ApplicationController
  before_filter :require_user, :except => [:index, :show]
  
  # GET /lyrics
  # GET /lyrics.xml
  def index
    @lyrics = Lyric.order('lyrics.created_at DESC').paginate(:per_page => 10, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lyrics }
    end
  end

  # GET /lyrics/1
  # GET /lyrics/1.xml
  def show
    @lyric = Lyric.find(params[:id])
    @background_story = @lyric.background_stories.build
    @note = @lyric.notes.build

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @lyric }
    end
  end

  # GET /lyrics/new
  # GET /lyrics/new.xml
  def new
    @lyric = Lyric.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @lyric }
    end
  end

  # GET /lyrics/1/edit
  def edit
    @lyric = Lyric.find(params[:id])
  end

  # POST /lyrics
  # POST /lyrics.xml
  def create
    @lyric = Lyric.new(params[:lyric])
    @lyric.created_by = current_user
    @lyric.updated_by = current_user

    respond_to do |format|
      if @lyric.save
        format.html { redirect_to(@lyric, :notice => 'Lyric was successfully created.') }
        format.xml  { render :xml => @lyric, :status => :created, :location => @lyric }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @lyric.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lyrics/1
  # PUT /lyrics/1.xml
  def update
    @lyric = Lyric.find(params[:id])
    params[:lyric][:updated_by_id] = current_user.id
    
    respond_to do |format|
      if @lyric.update_attributes(params[:lyric])
        format.html { redirect_to(@lyric, :notice => 'Lyric was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @lyric.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lyrics/1
  # DELETE /lyrics/1.xml
  def destroy
    @lyric = Lyric.find(params[:id])
    @lyric.destroy

    respond_to do |format|
      format.html { redirect_to(lyrics_url) }
      format.xml  { head :ok }
    end
  end
end
