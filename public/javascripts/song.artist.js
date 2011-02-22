$(function(){
  $('#releases .release').click(function(e){
    e.preventDefault();
    
    var release = $(this);
    $('#releases .release').removeClass('selected_release');
    release.addClass('selected_release');
    $('.songs').hide();
    $('#'+release.attr('rel')).show();
  });
});