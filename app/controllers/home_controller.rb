class HomeController < ApplicationController
  def index
    @recent_songs = Song.recent_updated.order('created_at DESC').limited(5)
    @meaningful_songs = Song.recent_updated.order('created_at ASC').limited(5)
  end
end
