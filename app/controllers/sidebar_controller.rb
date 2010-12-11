class SidebarController < ApplicationController
  def show
    params[:h] == "www.youtube.com" ? @is_supported = true : @is_supported = false
    if @is_supported
      @lyric = SongImporter.import_song(:query => params[:q], :video_url => params[:u], :current_user_id => current_user.try(:id))
      if @lyric.class == Lyric
        @background_story = @lyric.background_stories.build
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