class HomeController < ApplicationController
  def index
    if current_user
      voter_ids = current_user.following_users.collect { |u| u.id }
      @votes = Vote.following_feeds(voter_ids)
      
      render 'home/user'
    else
      @recent_songs = Song.recent_updated.order('created_at DESC').limited(5)
      render 'home/visitor'
    end
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
