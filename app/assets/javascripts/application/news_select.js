function initializeChangeNewsControls() {
  var exports = {};
  var $selector = $('.js-filter-news-by-reform');

  var options = {
      width: 'auto',
      minimumResultsForSearch: -1, // removes search bar
      dropdownAutoWidth : true
    };

  function filter_news() {
    var selectedFilter = $selector.val();
    if(selectedFilter == 'default') {
      $('.newsList-item').show();
    } else {
      $('.newsList-item').hide();
      $( '.newsList-item[data-reform="'+selectedFilter+'"').show();
    }
  }



  exports.setup = function() {
    $selector.change(filter_news);
  }

  return exports;
}
