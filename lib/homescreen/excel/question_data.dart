import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

import 'question.dart';

class QuestionData {

  Future<List<Question>>fillQuestionData() async {
    await Future.delayed(Duration(seconds: 1));
    List<Question> questions = [];
    ByteData data = await rootBundle.load("assets/data.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      var rows = excel.tables[table]?.rows;
      if (rows != null) {
        for (var row in rows) {
          fillData(row, questions);
        }
      }
    }
    return questions;
  }

  void fillData(List row, List<Question> questions) {
    if (row != null && row.length > 2) {
      List<String> answers = [];
      for (var i = 1; i < row.length - 1; i++) {
        answers.add(row[i].toString());
      }
      questions.add(Question(row[0], answers, row[row.length - 1].toString()));
    }
  }

  void fillQuestionDataNotAsync() {
    fillQuestionData();
  }
}
