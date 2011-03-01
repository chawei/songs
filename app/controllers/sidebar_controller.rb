class SidebarController < ApplicationController
  def show
    if current_user
      @votes = current_user.following_feeds
    else
      @user_session = UserSession.new
    end 
    
    @is_sidebar = true
    params[:h] == "www.youtube.com" ? @is_supported = true : @is_supported = false
    if @is_supported
      @song = SongImporter.import_song(:query => params[:q], :video_url => params[:u], :current_user_id => current_user.try(:id))
      @song.performer.grab_info if @song && @song.performer.bio_summary.blank?
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