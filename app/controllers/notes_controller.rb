class NotesController < ApplicationController
  before_filter :require_user, :except => [:index, :show]
  before_filter :find_song, :only => [:new, :show, :edit]
  
  # GET /notes
  # GET /notes.xml
  def index
    @notes = Note.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @notes }
    end
  end

  # GET /notes/1
  # GET /notes/1.xml
  def show
    @note = Note.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @note }
    end
  end

  # GET /notes/new
  # GET /notes/new.xml
  def new
    @note = @song.notes.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @note }
    end
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
    respond_to do |format|
      format.html { render :action => :new }
      format.js   { render :layout => false }
    end
  end

  # POST /notes
  # POST /notes.xml
  def create
    @note = Note.new(params[:note])
    @note.created_by = current_user

    respond_to do |format|
      if @note.save
        format.html { redirect_to(@note.song, :notice => 'Note was successfully created.') }
        format.js   { render :layout => false }
        format.xml  { render :xml => @note, :status => :created, :location => @note }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /notes/1
  # PUT /notes/1.xml
  def update
    @note = Note.find(params[:id])
    
    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to(@note.song, :notice => 'Note was successfully updated.') }
        format.js   { render :layout => false }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.xml
  def destroy
    @note = Note.find(params[:id])
    @note_id = @note.id
    @song = @note.song
    @note.destroy

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
