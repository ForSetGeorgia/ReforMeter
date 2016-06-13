function highchartsExternalIndicatorBar(chartData) {
  var options = {
    chart: {
      type: 'column'
    },
    exporting: {
      enabled: true
    },
    series: chartData.series,
    title: {
      text: chartData.title
    },
    xAxis: {
      categories: chartData.categories,
      tickmarkPlacement: 'on'
    }
  };

  return Highcharts.merge(options);
}