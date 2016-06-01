function createChart(chartData) {
  var chartType = chartData.chartType;
  var chart;

  if (chartType === 'small-meter-gauge') {
    var chart = smallMeterGauge(chartData, chartData.id);
  } else if (chartType === 'big-meter-gauge') {
    var chart = bigMeterGauge(chartData, chartData.id);
  } else if (chartType === 'expert-history-time-series') {
    var chart = expertHistoryTimeSeries(chartData);
  } else {
    throw new Error('Correct chart type not provided');
  }

  chart.create();
}

function setupCharts() {
  if (gon.charts) {
    for (var i = 0; i < gon.charts.length; i++) {
      var chartData = gon.charts[i];
      createChart(chartData);
    }
  }
}
