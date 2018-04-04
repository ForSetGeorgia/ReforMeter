
// show the embed code when the text changes
function setupPuzzleEmbed(){
  $('textarea.puzzle_embed_code').on('change', function(){
    if ($(this).val().length > 0){
      $(this).closest('div').find('.js-show-embed').html($(this).val());
    } else {
      // no text, so remove any video code
      $(this).closest('div').find('.js-show-embed').html('');
    }
  });
}

function setupPuzzleDatePicker() {
  if($('input#puzzle_date').length > 0){
    // load the date pickers
    $('#puzzle_date').datepicker({
        dateFormat: 'yy-mm-dd',
    });

    if (gon.date !== undefined &&
        gon.date.length > 0)
    {
      $("#puzzle_date").datepicker("setDate", new Date(gon.date));
    }
  }

}

