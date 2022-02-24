import 'package:advanced_quiz_app/excel/question_data.dart';
import 'package:advanced_quiz_app/quiz/answer_widget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'quiz/question_widget.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<QuestionData> _futureQuestionData;
  late QuestionData questionData;
  int i = 0;
  double percentage = 0;

  @override
  void initState() {
    super.initState();
    this._futureQuestionData =  fetchDataFromExcelFile();
    this._futureQuestionData.then((value) {
      this.questionData = value;
    });
  }

  Future<QuestionData> fetchDataFromExcelFile() async {
    QuestionData questionData = QuestionData();
    await questionData.fillQuestionData();
    return questionData;
  }

  void next() {
    this.percentage =  1 * (this.i + 1) / this.questionData.questions.length;
    setState(() {
      if (this.i < this.questionData.questions.length - 1) {
        this.i++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
      ),
      body: Container(
        color: Colors.lightBlueAccent,
        child: FutureBuilder<QuestionData>(
          future: _futureQuestionData,
          builder: (BuildContext context, AsyncSnapshot<QuestionData> snapshot) {
            if(snapshot.hasData) {
              return buildQuestionScreen();
            } else {
              return Text("Reading Excel File");
            }
          },
        )
      ),
    );
  }

  Column buildQuestionScreen() {
    return Column(
          children: [
            QuestionWidget(this.questionData.questions[this.i].question_text,
                Colors.white),
            buildProgressBar(),
            ...(this.questionData.questions[this.i].answers as List<String>)
                .map((answer) {
              return AnswerWidget(answer, next);
            }).toList()
          ],
        );
  }
  Widget buildProgressBar() {
    return Container(
        margin: EdgeInsets.all(20),
        child: new LinearPercentIndicator(
          lineHeight: 20.0,
          barRadius: Radius.circular(10),
          animateFromLastPercent: true,
          animationDuration: 1000,
          percent: this.percentage,
          center: Text((this.percentage * 100).toString() + "%"),
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: Colors.blue,
        ),
      );
  }
}
