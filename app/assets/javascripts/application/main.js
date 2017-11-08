(function() {
  $(document).ready(function() {
    setup_navigation_menu();
    setupSelect2();
    setupVerdictTimePeriodSelect();
    setupSubscribe();
    initializeChangeReformPageControls().setup();
    initializeScrollToIdSelect().setup();
    initializeChangeEconomicEffectsControls().setup();
    initializeChangeNewsControls().setup();
    initializeEconomicEffectsScrollToTop();

    var charts = setupCharts();

    initializeInfoCircles().setup();

    applyBrowserSpecificHacks();

    if ($('body.root.reforms').length > 0) {
      var colorfulReformsTimeSeries = charts.filter(function() {
        return $(this.highchartsObject.renderTo).data('id') === 'reforms-government-history-series';
      });
      if(colorfulReformsTimeSeries.length)
        setupReformSelects(colorfulReformsTimeSeries[0]);
    }

    if ($("body").hasClass("root download_data_and_reports")) {
      activate_download_events();
    }
  });

  $(document).on('page:change', function() {
    $('html').attr('lang', gon.locale);
    setupTabs();
    setupAccordions();

    if ($('body.root.review_board').length > 0) openExpertsTab();
  });
})();
