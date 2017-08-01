$(document).ready(function(){
  $('#dev-div').hide();
  $('#dev-button').on('click', function(e){
    e.preventDefault();
    $('#org-div').hide();
    $('#dev-div').toggle();
  });
  $('#org-div').hide();
  $('#org-button').on('click', function(e){
    e.preventDefault();
    $('#dev-div').hide();
    $('#org-div').toggle();
  });
});
