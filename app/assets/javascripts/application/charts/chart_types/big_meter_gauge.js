function highchartsBigMeterGaugeOptions(chartData) {
  var color = chartData.color;

  var options = {
    title: {
      text: chartData.title,
      y: 15
    },

    pane: {
      size: '200'
    },

    yAxis: {
      plotBands: [
        {
          borderWidth: 2,
          borderColor: 'transparent',
          from: 0,
          to: 3.3,
          color: outputHighchartsColorString(color, '.6'),
          innerRadius: '40%',
          outerRadius: '100%',
          label: meterGaugePlotBandLabels.behind(chartData)
        },{
          borderWidth: 2,
          borderColor: 'transparent',
          from: 3.3,
          to: 6.6,
          color: outputHighchartsColorString(color, '.8'),
          innerRadius: '40%',
          outerRadius: '100%',
          label: meterGaugePlotBandLabels.onTrack(
            chartData,
            {
              y: 30
            }
          )
        },{
          borderWidth: 2,
          borderColor: 'transparent',
          from: 6.6,
          to: 10,
          color: outputHighchartsColorString(color, '1'),
          innerRadius: '40%',
          outerRadius: '100%',
          label: meterGaugePlotBandLabels.ahead(
            chartData,
            {
              y: localeIs('ka') ? 35 : 45
            }
          )
        }
      ]
    },

    series: [{
      name: chartData.title,
      data: [chartData.score],
      dataLabels: {
        borderWidth: 0,
        y: 70,
        useHTML: true,
        formatter: function() {
          return highchartsGaugeLabel(chartData, this, '3.5em');
        }
      },
      pivot: {
        backgroundColor: 'white'
      },
      dial: {
        baseWidth: 20,
        backgroundColor: 'rgba(0, 0, 0, 0.7)',
        baseLength: 0,
        radius: '60%',
        rearLength: '10%'
      }
    }]

  };

  return Highcharts.merge(
    highchartsMeterGaugeOptions(chartData),
    options
  );

}
