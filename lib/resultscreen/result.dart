import 'package:flutter/material.dart';

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

  _ResultState(this.totalAmountOfQuestions, this.totalAmountOfCorrectAnswers);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.lightGreen,
        child: Text("Sie haben: " +
            this.totalAmountOfCorrectAnswers.toString() +
            " von " +
            this.totalAmountOfQuestions.toString() +
            " Antworten richtig"),
      ),
    );
  }
}
