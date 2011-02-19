// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  $('#container').removeClass('no_js').addClass('js');
  
  //$('#lyric_show_container form').hide();
  
  /*
  $('#lyric_show_container .section .add_btn').click(function() {
    var form = $(this).parents('.section').find('#add_new_form_container form');
    if (form.hasClass('expanded')) {
      form.removeClass('expanded').slideUp();
    } else {
      form.addClass('expanded').slideDown();
    }
    return false;
  });
  */
  
  $('.tab_content .add_btn').click(function() {
    var form = $(this).parents('.tab_content').find('#add_new_form_container form');
    if (form.hasClass('expanded')) {
      form.removeClass('expanded').slideUp();
    } else {
      form.addClass('expanded').slideDown();
    }
    return false;
  });
  
  $('.tab_content .cancel_btn').live('click', function() {
    $(this).parents('form').removeClass('expanded').slideUp();
    var item = $(this).parents('.item');
    if(item.length > 0) {
      item.find('.title').show();
      item.find('.content').show();
    }
    return false;
  });
  
  $('.edit_lyric_btn').live('click', function() {
    if($(this).hasClass('click_to_edit')) {
      $(this).removeClass('click_to_edit').addClass('click_to_hide');
      $('#lyric').hide();
      $('#lyric_form').removeClass('js_hidden').hide().fadeIn();
      $(this).text('cancel');
    } else if ($(this).hasClass('click_to_hide')) {
      $(this).removeClass('click_to_hide').addClass('click_to_edit');
      $('#lyric').fadeIn();
      $('#lyric_form').addClass('js_hidden').hide();
      $(this).text('edit the lyrics');
    }
    return false;
  });
  
  $('.ajax_video').click(function() {
    var video_item = $(this).parents('.video_item')
    $('.video_item').removeClass('selected_video_item');
    video_item.addClass('selected_video_item');
  });

  $('[rel=tipsy]').tipsy({gravity: 'n'});
  //$('.vote_block .action').tipTip();
  
  $('.autogrow').autogrow();
  
  
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

$.fn.clearForm = function() {
  $(this).find('.msg').empty();
  return this.each(function() {
    var type = this.type, tag = this.tagName.toLowerCase();
    if (tag == 'form')
      return $(':input',this).clearForm();
    if (type == 'text' || type == 'password' || tag == 'textarea') {
      this.value = '';
    }
    else if (type == 'checkbox' || type == 'radio')
      this.checked = false;
    //else if (tag == 'select')
    //  this.selectedIndex = -1;
  });
};
