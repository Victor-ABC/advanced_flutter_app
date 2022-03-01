import 'package:advanced_quiz_app/homescreen/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnswerWidget extends StatelessWidget{
  String content;
  void Function()? callback;
  String correctAnswer;
  AnswerWidget(this.content, this.callback, this.correctAnswer);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: Colors.white)
        ),
        onPressed: () {
          if(this.content == this.correctAnswer) {
            HomeState.correctAnswerCounter++; //richtige antwort wird gemerkt
          }
          this.callback!();
        },
        child: Text(this.content),
      ),
    );
  }
}