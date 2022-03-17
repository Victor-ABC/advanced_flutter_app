import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
 Datenklassen bilden Zustände der App ab
 mit ChangeNotifier wird das ObserverPattern realisiert.
 es können sich N Listener auf "ColorModel" registrieren
 */
class ColorModel extends ChangeNotifier {
  Color _color = Colors.lightBlueAccent;
  Color get color => _color;

  void setColor(Color color) {
    _color = color;
    notifyListeners(); //tells all listners, that color has changed
  }
}