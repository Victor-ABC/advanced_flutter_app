import 'package:advanced_quiz_app/homescreen/home.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ResultScreen extends StatefulWidget {
  int totalAmountOfCorrectAnswers;
  int totalAmountOfQuestions;

  ResultScreen(this.totalAmountOfCorrectAnswers, this.totalAmountOfQuestions);

  @override
  _ResultState createState() => _ResultState(
      this.totalAmountOfQuestions, this.totalAmountOfCorrectAnswers);
}

class _ResultState extends State<ResultScreen> {
  int totalAmountOfCorrectAnswers;
  int totalAmountOfQuestions;
  late List<Statistics> _statistics;

  @override
  void initState() {
    _statistics = getStatistics();
    super.initState();
  }

  _ResultState(this.totalAmountOfQuestions, this.totalAmountOfCorrectAnswers);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Quiz"),
          centerTitle: true,
        ),
        body: SfCircularChart(
          backgroundColor: HomeState.global_background_color,
          title: ChartTitle(
            text: 'Statistiken',
            textStyle: TextStyle(
              color: Colors.white,
            ),
          ),
          legend: Legend(
            isVisible: true,
            overflowMode: LegendItemOverflowMode.wrap,
          ),
          series: <CircularSeries>[
            PieSeries<Statistics, String>(
              //PieSeries -> DoughnutSeries
              //PieSeries -> RadialBarSeries
              dataSource: _statistics,
              xValueMapper: (Statistics data, _) => data.label,
              yValueMapper: (Statistics data, _) => data.amount,
              dataLabelSettings: DataLabelSettings(
                isVisible: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Statistics> getStatistics() {
    final List<Statistics> statistics = [
      Statistics(
        "richtig",
        this.totalAmountOfCorrectAnswers,
      ),
      Statistics(
        "falsch",
        this.totalAmountOfQuestions - this.totalAmountOfCorrectAnswers,
      )
    ];
    return statistics;
  }
}

class Statistics {
  final String label;
  final int amount;

  Statistics(this.label, this.amount);
}