import 'package:advanced_quiz_app/model/color_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homescreen/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ColorModel(),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Advanced Quiz App",
      home: Home(),
    );
  }
}
