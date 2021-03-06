function highchartsExternalIndicatorAreaTimeSeries(chartData) {
  var externalIndicatorChart = externalIndicatorChartHelpers(chartData);
  var indexBoxes = initializeExternalIndicatorIndexBoxes(chartData, this);
  var color = externalIndicatorChart.colorHash;
  var max = chartData.max;
  var spacingLeft = externalIndicatorChart.spacingLeft;

  if (typeof(chartData.displayTitle) === 'undefined') chartData.displayTitle = true;
  if (typeof(chartData.displaySubtitle) === 'undefined') chartData.displaySubtitle = true;

  styleBenchmarkLineIfExists(chartData)

  var options = {
    chart: {
      // Makes room for the yAxis plot band labels
      spacingLeft: spacingLeft,
      type: 'areaspline',
      height: '300'
    },
    exporting: {
      chartOptions: {
        title: externalIndicatorChart.title(
          chartData.title,
          {
            titleOptions: {
              x: -1 * spacingLeft + 10
            }
          }
        )
      }
    },
    plotOptions: {
      areaspline: {
        color: '#f7d95c',
        fillColor: {
          linearGradient: {
            x1: 0,
            y1: 0,
            x2: 0,
            y2: 1
          },
          stops: [
            [0, '#faa24f'],
            [1, '#f7d95c']
          ]
        },
        lineWidth: 0,
        marker: {
          enabled: false
        }
      }
    },
    series: chartData.series,
    subtitle: externalIndicatorChart.subtitle(
      chartData.displaySubtitle ? chartData.subtitle : null,
      {
        x: -1 * spacingLeft + 10
      }
    ),
    title: externalIndicatorChart.title(
      chartData.displayTitle ? chartData.title : null,
      {
        description: chartData.description,
        titleOptions: {
          x: -1 * spacingLeft + 10
        }
      }
    ),
    tooltip: getHighchartsTooltip(chartData, {
      preFormatterCallback: function(tooltipData) {
        indexBoxes.update(tooltipData);
      }
    }),
    yAxis: {
      min: chartData.min,
      max: chartData.max,
      plotBands: externalIndicatorChart.plotBands(chartData.plot_bands, false),
      title: {
        text: chartData.unitLabel
      }
    }
  };

  return Highcharts.merge(
    historyTimeSeriesOptions(chartData),
    options
  );
}
