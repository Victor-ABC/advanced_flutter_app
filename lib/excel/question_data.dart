import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

import 'question.dart';

class QuestionData {
  List<Question> questions = [];

  fillQuestionData() async {
    ByteData data = await rootBundle.load("assets/data.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      var rows = excel.tables[table]?.rows;
      if (rows != null) {
        for (var row in rows) {
          fillData(row);
        }
      }
    }
  }

  void fillData(List row) {
    if (row != null && row.length > 2) {
      List<String> answers = [];
      for (var i = 1; i < row.length; i++) {
        answers.add(row[i]);
      }
      print("Question:" + row[0].toString());
      print("Answers: " + answers.toString());
      this.questions.add(Question(row[0], answers));
    }
  }

  void fillQuestionDataNotAsync() {
    fillQuestionData();
  }
}
