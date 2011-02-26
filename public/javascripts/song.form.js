$(function() {  
  $('.tab_content .add_btn').click(function() {
    var form = $(this).parents('.tab_content').find('#add_new_form_container form');
    if (form.hasClass('expanded')) {
      form.removeClass('expanded').hide();
    } else {
      form.addClass('expanded').show();
    }
    return false;
  });
  
  $('.tab_content .edit_btn').live('click', function() {
    var form = $(this).parents('.item').find('.form_container form');
    if (form.hasClass('expanded')) {
      form.removeClass('expanded').hide();
    } else {
      form.addClass('expanded').show();
    }
    return false;
  });
  
  $('.tab_content .cancel_btn').live('click', function() {
    var cancel_btn = $(this);
    cancel_btn.parents('form').removeClass('expanded').hide(function(){
      var item = cancel_btn.parents('.item');
      if(item.length > 0) {
        item.find('.title').show();
        item.find('.content').show();
      }
    });
    return false;
  });
  
  $('.tab_content .save_btn').live('click', function() {
    var save_btn = $(this);
    var form = save_btn.parents('form');
    var textarea = form.find('textarea');
    if (textarea.val().length == 0) {
      textarea.val("Please enter some text...").addClass('error');
    } else {
      save_btn.val('saving..');
      save_btn.submit();
    }
    return false;
  });
  
  $('.tab_content form textarea').live('click', function(){
    var textarea = $(this);
    if (textarea.hasClass('error')) {
      textarea.val("").removeClass('error');
    }
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
  
  $('.autogrow').autogrow();
  
  /* Stories */
  $('#story_section form .title').watermark('Title (Optional)');
  $('#story_section form .content').watermark('Write your note here...');
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
