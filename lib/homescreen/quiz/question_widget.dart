import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget{
  String content;
  Color color;
  QuestionWidget(this.content, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Text(
          this.content,
          style: TextStyle(
            color: this.color,
            fontSize: 24,
          ),
      ),
    );
  }
}
