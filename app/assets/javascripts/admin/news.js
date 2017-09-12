//= require jquery-ui/sortable

// update the sort order to be the index values
function updateTableIndex(tables){
  $(tables).each(function(){
    $(this).find('tr').each(function(index){
      $(this).find('td.js-has-sort-order input.sort-order').val(index);
    });
  });
}

function setupNewsCocoon(){
  // add slideshow image
  $('.js-optional-countries .tab-pane').on('cocoon:after-insert', function(e, insertedItem) {
    // update the row indices
    updateTableIndex($(this).closest('tbody'));
  });
}


// move table rows up and down to change order
function setupNewsMove(){

  $('table.table-news-slideshows').on('click', 'tr.nested-fields a.move-up', function(){
    var $row = $(this).closest('tr');

    // cannot use jquery next for cocoon puts hidden fields in between
    // tr tags, so have to look for next by hand
    var $rows = $row.closest('tbody').find('tr');
    var index = $rows.index($row);
    if (index > 0){
      $row.insertBefore($rows[index-1]);
    }


    // update the row indices
    updateTableIndex($(this).closest('tbody'));

    return false;
  });

  $('table.table-news-slideshows').on('click', 'tr.nested-fields a.move-down', function(){
    var $row = $(this).closest('tr');

    // cannot use jquery next for cocoon puts hidden fields in between
    // tr tags, so have to look for next by hand
    var $rows = $row.closest('tbody').find('tr');
    var index = $rows.index($row);
    if (index < $rows.length-1){
      $row.insertAfter($rows[index+1]);
    }

    // update the row indices
    updateTableIndex($(this).closest('tbody'));

    return false;
  });

}

// show the embed video when the text changes
function setupNewsVideoEmbed(){
  $('textarea#news_video_embed').on('change', function(){
    if ($(this).val().length > 0){
      $('.js-show-video').html($(this).val());
    } else {
      // no text, so remove any video code
      $('.js-show-video').html('');
    }
  });
}

function setupNewsDatePicker() {
  if($('input#news_date').length > 0){
    // load the date pickers
    $('#news_date').datepicker({
        dateFormat: 'yy-mm-dd',
    });

    if (gon.date !== undefined &&
        gon.date.length > 0)
    {
      $("#news_date").datepicker("setDate", new Date(gon.report_date));
    }
  }

}

function setupNewsResetReform() {
  $('.btn-reset-reform').on('click', function(){
    $('input[name="news[reform_id]"]').each(function(){
      $(this).attr('checked',false);
    });
    return false;
  });
}

