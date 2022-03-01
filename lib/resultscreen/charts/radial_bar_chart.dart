import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../homescreen/home.dart';
import '../statistics.dart';

class RadialBarChart extends StatelessWidget {
  List<Statistics> _statistics;
  RadialBarChart(this._statistics);

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      backgroundColor: HomeState.global_background_color,
      title: ChartTitle(
        text: 'Deine Ergebnisse',
        textStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      series: <CircularSeries>[
        RadialBarSeries<Statistics, String>(
          //PieSeries -> DoughnutSeries
          //PieSeries -> RadialBarSeries
          dataSource: _statistics,
          xValueMapper: (Statistics data, _) => data.label,
          yValueMapper: (Statistics data, _) => data.amount,
          pointColorMapper: (Statistics data, _) => data.color,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
          ),
        ),
      ],
    );
  }
}