import 'package:advanced_quiz_app/homescreen/excel/question.dart';
import 'package:advanced_quiz_app/homescreen/excel/question_data.dart';
import 'package:advanced_quiz_app/homescreen/quiz/answer_widget.dart';
import 'package:advanced_quiz_app/model/color_model.dart';
import 'package:advanced_quiz_app/resultscreen/result.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../secondscreen/sencond.dart';
import './quiz/question_widget.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {

  HomeState() {
    correctAnswerCounter = 0;
    i = 0;
    percentage = 0;
  }
  static int correctAnswerCounter = 0;
  late Future<List<Question>> _futureQuestionData;
  late List<Question> questionList;
  int i = 0;
  double percentage = 0;

  @override
  void initState() {
    super.initState();
    this._futureQuestionData = QuestionData().fillQuestionData();
    this._futureQuestionData.then((result) {
      this.questionList = result;
    });
  }

  void next() {
    this.percentage =  1 * (i + 1) / questionList.length;
    setState(() {
      if (i < questionList.length - 1) {
        i++;
      } else {
        navigateToResultPage();
      }
    });
  }

  void navigateToResultPage() {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (ctxt) => new ResultScreen(
        correctAnswerCounter,
        this.questionList.length
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorModel>(
      builder: (context, colors, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Quiz"),
            centerTitle: true,
          ),
          body: Container(
              color: colors.color,
              child: FutureBuilder(
                future: _futureQuestionData,
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return buildQuestionScreen();
                  } else {
                    return splashScreen();
                  }
                },
              )
          ),
        );
      },
    );
  }

  Column buildQuestionScreen() {
      return Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: ElevatedButton(
              onPressed : navigateToSecondPage,
              child: Icon(Icons.settings),
            )
          ),
          QuestionWidget(questionList[i].question_text,
              Colors.white),
          buildProgressBar(),
          ...(questionList[i].answers as List<String>)
              .map((answer) {
            return AnswerWidget(answer, next, questionList[i].correctAnswer);
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

  Widget splashScreen() {
    return Center(child: CircularProgressIndicator());
  }

  void navigateToSecondPage() {
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (ctxt) => new SecondScreen()),
      );
  }
}
