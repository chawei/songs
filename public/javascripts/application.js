// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function replaceURLWithHTMLLinks(text) {
  var exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/i;
  return text.replace(exp,"<a href='$1'>$1</a>"); 
}

$(function() {
  $('#container').removeClass('no_js').addClass('js');
  
  replaceURLWithHTMLLinks();
  //$('#lyric_show_container form').hide();
  
  $('#lyric_show_container .section .add_btn').click(function() {
    var form = $(this).parents('.section').find('form');
    if (form.hasClass('expanded')) {
      form.removeClass('expanded').slideUp();
    } else {
      form.addClass('expanded').slideDown();
    }
    return false;
  });
  
  $('#lyric_show_container .section .cancel_btn').click(function() {
    $(this).parents('form').removeClass('expanded').slideUp();
    return false;
  });
});
