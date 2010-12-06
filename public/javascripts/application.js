// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  $('#container').removeClass('no_js').addClass('js');
  
  //$('#lyric_show_container form').hide();
  
  $('#lyric_show_container .section .add_btn').click(function() {
    var form = $(this).parents('.section').find('#add_new_form_container form');
    if (form.hasClass('expanded')) {
      form.removeClass('expanded').slideUp();
    } else {
      form.addClass('expanded').slideDown();
    }
    return false;
  });
  
  $('.tab_content .add_btn').click(function() {
    var form = $(this).parents('.tab_content').find('#add_new_form_container form');
    if (form.hasClass('expanded')) {
      form.removeClass('expanded').slideUp();
    } else {
      form.addClass('expanded').slideDown();
    }
    return false;
  });
  
  $('#lyric_show_container .section .cancel_btn, .tab_content .cancel_btn').live('click', function() {
    $(this).parents('form').removeClass('expanded').slideUp();
    var item = $(this).parents('.item');
    if(item.length > 0) {
      item.find('.title').show();
      item.find('.content').show();
    }
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
