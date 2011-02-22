// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  $('#container').removeClass('no_js').addClass('js');
  $('#tabs').removeClass('js_hidden');

  $('.ajax_video').click(function() {
    var video_item = $(this).parents('.video_item')
    $('.video_item').removeClass('selected_video_item');
    video_item.addClass('selected_video_item');
  });

  $('[rel=tipsy]').tipsy({gravity: 'n'});
  $('[rel=left-tipsy]').tipsy({gravity: 'e'});
  $('[rel=top-tipsy]').tipsy({gravity: 's'});
  //$('.vote_block .action').tipTip();

  /* Vote Block */
  $('.vote_block .action').click(function(){
    var btn = $(this);
    if (btn.hasClass('thumbs_true')) {
      btn.removeClass('thumbs_true');
    } else {
      btn.parent('.vote_block').find('.action').removeClass('thumbs_true');
      btn.addClass('thumbs_true');
    }
  });
  
});
