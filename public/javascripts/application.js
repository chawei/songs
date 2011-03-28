// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  
  $('#container').removeClass('no_js').addClass('js');
  $('#tabs, #profile_tabs').removeClass('js_hidden');
  
  $('[rel=tipsy]').tipsy({gravity: 'n'});
  $('[rel=left-tipsy]').tipsy({gravity: 'e'});
  $('[rel=top-tipsy]').tipsy({gravity: 's'});
  //$('.vote_block .action').tipTip();

  /* Video */
  $('.ajax_video').click(function() {
    var video_item = $(this).parents('.video_item')
    $('.video_item').removeClass('selected_video_item');
    video_item.addClass('selected_video_item');
  });

  /* Search */
  $('#search').watermark('Artist name or Song title');
  
  /* Vote Block */
  $('.vote_block .action').live('click', function(){
    var btn = $(this);
    if (btn.hasClass('thumbs_true')) {
      btn.removeClass('thumbs_true');
    } else {
      btn.parent('.vote_block').find('.action').removeClass('thumbs_true');
      btn.addClass('thumbs_true');
    }
  });
  
  /* Follow Block */
  $('.follow_block .action').click(function(){
    var btn = $(this);
    var submit_btn = btn.find('.submit_btn');
    if (btn.hasClass('follow_true')) {
      btn.removeClass('follow_true');
      submit_btn.val('Follow');
    } else {
      btn.addClass('follow_true');
      submit_btn.val('Unfollow');
    }
  });
  
  /* Login */
  $('a#account_btn').click(function(e){
    e.preventDefault();
    if ($('#login_box .actions').hasClass('hidden')) {
      $('a#account_btn').addClass('selected');
      $('#login_box .actions').removeClass('hidden');
    } else {
      $('a#account_btn').removeClass('selected');
      $('#login_box .actions').addClass('hidden');
    }
  });
  
  $('body').click(function(e){
    if (e.target.id != "account_btn") {
      $('a#account_btn').removeClass('selected');
      $('#login_box .actions').addClass('hidden');
    }
  });
  
  
  $('a.popup_search_lyrics').click(function() {
      var href = $(this).attr("href");
      window.open(href, '_blank', 'location=yes,menubar=yes,resizable=yes,scrollbars=yes,width=800,height=500');
      
      return false;
  });
  
  
  /* Beta Request */
  $('#beta_request_email').watermark('Enter your email here');
  
  $('form#new_beta_request').bind("ajax:success", function(e, data, status, xhr) {
    var msg_elem = $('form#new_beta_request .msg');
    if (data.errors) {
      msg_elem.addClass('error_msg').html(data.errors[0]);
    } else {
      msg_elem.removeClass('error_msg').html('thanks for your request and we\'ll see you soon!');
      $('#beta_request_email').val('');
    }
  });
  
});
