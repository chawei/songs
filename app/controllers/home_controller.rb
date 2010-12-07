class HomeController < ApplicationController
  def index
    @recent_lyrics = Lyric.recent_updated.order('created_at DESC').limited(5)
  end
end
