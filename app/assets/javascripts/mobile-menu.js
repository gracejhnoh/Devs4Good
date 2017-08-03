$(document).ready(function() {
  $('#mobile-menu').hide();
  $('#mobile-menu-title').on('click', function(e){
    e.preventDefault();
    $('#mobile-menu').toggle();
  })
});
