import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnswerWidget extends StatelessWidget{
  String content;
  void Function()? callback;
  AnswerWidget(this.content, this.callback);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: Colors.white)
        ),
        onPressed: this.callback,
        child: Text(this.content),
      ),
    );
  }
}