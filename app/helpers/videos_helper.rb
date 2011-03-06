module VideosHelper
  def embedded_player(video_id, size='large')
    width, height = '315', '255'
    if size == 'large'
      width, height = '400', '300'
    end
    player_code = "
      <object style='width: #{width}px; height: #{height}px' id='ytplayer'>
        <param name='movie' value='http://www.youtube.com/e/#{video_id}?enablejsapi=1&version=3'>
        <param name='allowFullScreen' value='true'>
        <param name='allowScriptAccess' value='always'>
        <embed src='http://www.youtube.com/e/#{video_id}?enablejsapi=1&version=3' type='application/x-shockwave-flash' allowfullscreen='true' allowScriptAccess='always' width='#{width}' height='#{height}'>
      </object>"
    html5_player_code = "
      <iframe class='youtube-player' type='text/html' width='#{width}' height='#{height}' 
              src='http://www.youtube.com/embed/#{video_id}' frameborder='0'>
      </iframe>"
    return player_code.html_safe
  end
  
  def refresh_vote_block(video)
    render :partial => 'shared/vote_block', :locals => { :resource => video }
  end
end
