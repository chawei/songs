class Api::V1::SongsController < ApplicationController  

  def search
    @song = SongFinder.find :query => params[:query], 
                            :video_url => params[:video_url], 
                            :current_user_id => current_user.try(:id)
    respond_to do |format|
      format.html  { render :json => @song }
    end
  end
  
  def show
    @song = Song.find(params[:id])
    @song.refresh_lyrics if @song.content.blank?
    @song.performer.grab_info if @song && @song.performer.bio_summary.blank?
    
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
      format.json  { render :json => @song }
    end
  end
end