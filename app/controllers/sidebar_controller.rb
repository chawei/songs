class SidebarController < ApplicationController
  def show
    @is_sidebar = true
    
    if current_user
      @votes = current_user.following_feeds
    else
      @user_session = UserSession.new
    end 
    
    if @is_supported = supported?(params[:h])
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
  
  private
  
    def supported?(hostname)
      hostname == "www.youtube.com" ? return true : return false
    end
  
end