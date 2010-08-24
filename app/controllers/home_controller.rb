class HomeController < ApplicationController
  def index
    @lyrics = Lyric.all
  end

end
