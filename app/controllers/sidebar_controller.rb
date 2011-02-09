class SidebarController < ApplicationController
  def show
    unless current_user
      @user_session = UserSession.new
    end 
    
    @is_sidebar = true
    params[:h] == "www.youtube.com" ? @is_supported = true : @is_supported = false
    if @is_supported
      @song = SongImporter.import_song(:query => params[:q], :video_url => params[:u], :current_user_id => current_user.try(:id))
      if @song.class == Song
        @background_story = @song.background_stories.build
      end
    end
    render :layout => 'sidebar'
  end
  
  def switch_video
    @video = Video.find(params[:id])
    respond_to do |format|
      format.js  { render :layout => false }
    end
  end
  
end