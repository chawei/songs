module VideosHelper
  def embedded_player(video_id)
    player_code = "
      <object style='width: 315px; height: 255px'>
        <param name='movie' value='http://www.youtube.com/v/#{video_id}?version=3'>
        <param name='allowFullScreen' value='true'>
        <param name='allowScriptAccess' value='always'>
        <embed src='http://www.youtube.com/v/#{video_id}?version=3' type='application/x-shockwave-flash' allowfullscreen='true' allowScriptAccess='always' width='315' height='255'>
      </object>"
    return player_code.html_safe
  end
end
