class HomeController < ApplicationController
  def index
    @recent_lyrics = Lyric.recent_updated.limited(5)
  end

end
