import 'package:advanced_quiz_app/homescreen/home.dart';
import 'package:advanced_quiz_app/resultscreen/statistics.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import './charts/pie_chart.dart';
import './charts/doughnut_chart.dart';
import 'charts/radial_bar_chart.dart';

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

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Sind sie sicher?'),
        content: new Text('Wollen sie das Quiz neu starten'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('Nein'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (ctxt) => new Home()),
              );
            },
            child: new Text('Ja'),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                title: Text("Quiz"),
                centerTitle: true,
                bottom: TabBar(
                  tabs: [
                    Tab(text: "Pie-Chart", icon: Icon(Icons.pie_chart),),
                    Tab(text: "Doughnut-Chart",icon: Icon(Icons.bar_chart),),
                    Tab(text: "Radial-Chart",icon: Icon(Icons.multiline_chart),),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  PieChart(_statistics),
                  DoughnutChart(_statistics),
                  RadialBarChart(_statistics),
                ],
              )
          ),
        ),
      )
    );
  }

  List<Statistics> getStatistics() {
    final List<Statistics> statistics = [
      Statistics(
        "richtig",
        this.totalAmountOfCorrectAnswers,
        Colors.lightGreen,
      ),
      Statistics(
        "falsch",
        this.totalAmountOfQuestions - this.totalAmountOfCorrectAnswers,
        Colors.red,
      )
    ];
    return statistics;
  }
}