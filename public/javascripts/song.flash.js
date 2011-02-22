$(function() {
  var flash_msgs = $('#flash_msgs');
  if (flash_msgs != undefined) {
    flash_msgs.find('div').delay(3000).fadeOut();
  }
});