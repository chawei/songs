class SongsController < ApplicationController
  before_filter :require_user, :except => [:index, :show]
  
  def next_song
    song = Song.find(session[:current_song_id])
    @next_song = song.next
    respond_to do |format|
      format.json  { render :json => @next_song }
    end
  end
  
  # GET /songs
  # GET /songs.xml
  def index
    @songs = Song.select('id, title').order('songs.created_at DESC').includes(:performers).paginate(:per_page => 10, :page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @songs }
    end
  end

  # GET /songs/1
  # GET /songs/1.xml
  def show
    @song = Song.find(params[:id])
    @song.refresh_lyrics if @song.content.blank?
    @song.performer.grab_info if @song && @song.performer.bio_summary.blank?
    
    @background_story = @song.background_stories.build
    @note = @song.notes.build
    @is_supported = true
    
    @song.get_youtube_video if @song.videos.embeddable.blank?
    @song.reload
    
    @votes = current_user.following_feeds if current_user
    
    if current_user && current_user.admin?
      @videos = @song.videos.embeddable
    else
      @videos = @song.videos.embeddable.exact
      if @videos.empty?
        Request.create(:query_url => "/songs/#{@song.id}", 
                       :request_type => 'video', :user_id => current_user.try(:id))
      end
    end
    
    if params['video_id'].blank?
      @video = @videos.first
    else
      @video = Video.find(params[:video_id])
    end

    session[:current_song_id] = @song.id
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @song }
    end
  end

  # GET /songs/new
  # GET /songs/new.xml
  def new
    @song = Song.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @song }
    end
  end

  # GET /songs/1/edit
  def edit 
    @song = Song.find(params[:id])
    unless current_user && (current_user.own_song?(@song) || current_user.admin?)
      redirect_to(@song, :notice => "Sorry, you don't have the access to edit this page.")
    end
  end

  # POST /songs
  # POST /songs.xml
  def create
    @song = Song.new(params[:song])
    @song.created_by = current_user
    @song.updated_by = current_user

    respond_to do |format|
      if @song.save
        format.html { redirect_to(@song, :notice => 'Song was successfully created.') }
        format.xml  { render :xml => @song, :status => :created, :location => @song }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @song.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /songs/1
  # PUT /songs/1.xml
  def update
    @song = Song.find(params[:id])
    params[:song][:updated_by_id] = current_user.id
    
    respond_to do |format|
      if @song.update_attributes(params[:song])
        format.html { redirect_to(@song, :notice => 'Song was successfully updated.') }
        format.js   { render :layout => false }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @song.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.xml
  def destroy
    @song = Song.find(params[:id])
    @song.destroy

    respond_to do |format|
      format.html { redirect_to(songs_url) }
      format.xml  { head :ok }
    end
  end
end
