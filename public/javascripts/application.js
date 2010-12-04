// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  $('#container').removeClass('no_js').addClass('js');
  
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
