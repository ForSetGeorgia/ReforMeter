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
    console.log(selectedFilter)
    if(selectedFilter == 'default') {
      $('article.news').show();
    } else {
      $('article.news').hide();
      console.log('article.news[data-reform="'+selectedFilter+'"]')
      $('article.news[data-reform="'+selectedFilter+'"]').show();
    }
  }



  exports.setup = function() {
    $selector.change(filter_news);
  }

  return exports;
}
