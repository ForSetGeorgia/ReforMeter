function highchartsSmallSolidGaugeOptions(chartData) {

  function scoreLabelText() {
    switch (chartData.change) {

      case 0: {
        return gon.translations.government.rating.middle;
      }

      case 1: {
        return gon.translations.government.rating.rising;
      }

    }

    return '';
  }

  scoreLabelText = scoreLabelText();

  function gaugeLabel(dataPoint, isExport) {
    return highchartsGaugeLabel(
      chartData,
      dataPoint,
      '2em',
      {
        unit: '%',
        changeIcon: !isExport,
        secondLineText: scoreLabelText
      }
    );
  }

  return {
  	chart: {
    	type: 'solidgauge',
      height: chartData.title ? '195' : '115'
    },

    exporting: {
      chartOptions: {
        pane: {
          background: {
            borderWidth: 2
          },
          center: ['50%', '72%']
        },
        plotOptions: {
        	solidgauge: {
            dataLabels: {
              formatter: function() {
                return gaugeLabel(this, true);
              }
            }
          }
        }
      }
    },

		title: {
      style: {
        fontSize: '1.4em'
      },
    	text: chartData.title,
      verticalAlign: 'top',
      widthAdjust: 0
    },

    pane: {
      center: ['50%', '58%'],
      size: '100',
      startAngle: -90,
      endAngle: 90,
      background: {
        backgroundColor: '#EEE',
        innerRadius: '0%',
        outerRadius: '100%',
        shape: 'arc',
        borderWidth: 0
      }
    },

    tooltip: {
      enabled: false
    },

    credits: {
      enabled: false
    },

    yAxis: {
    	min: 0,
      max: 100,
      tickWidth: 0,
      minorTickInterval: null,
      tickPixelInterval: 99999,
			lineWidth: 0,
      labels: {
        y: 16,
        enabled: false
      },
    	stops: [
      	[0, outputHighchartsColorString(chartData.color, '0.7', '#FFF')]
      ]
    },

    plotOptions: {
    	solidgauge: {
      	innerRadius: '0%',
        dataLabels: {
          borderWidth: 0,
          y: scoreLabelText === '' ? 38 : 50,
          useHTML: true,
          formatter: function() {
            return gaugeLabel(this, false);
          },
          tooltip: {
          	valueSuffix: '%'
          }
        }
      }
    },

    series: [{
			name: chartData.title,
      data: [chartData.score]
    }]
  };
}
