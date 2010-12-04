class SidebarController < ApplicationController
  def show_lyric
    params[:h] == "www.youtube.com" ? @is_supported = true : @is_supported = false
    if @is_supported
      @song = SongImporter.import_song(:query => params[:q], :video_url => params[:u], :current_user_id => current_user.try(:id))
    end
    render :layout => 'sidebar'
  end
  
end