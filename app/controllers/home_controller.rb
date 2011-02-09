class HomeController < ApplicationController
  def index
    @recent_songs = Song.recent_updated.order('created_at DESC').limited(5)
    @meaningful_songs = Song.recent_updated.order('created_at ASC').limited(5)
  end
  
  def search
    @songs = Song.search(
      (params[:search] || ""), 
      :page => (params[:page] || 1)
    )
    
    @artists = Artist.search(
      (params[:search] || ""), 
      :page => (params[:page] || 1)
    )
  end
end
