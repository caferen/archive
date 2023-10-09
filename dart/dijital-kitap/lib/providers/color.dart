import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Renk with ChangeNotifier {
  List<dynamic> determineColor(int index) {
    var clr;
    var secondClr;
    switch (index) {
      case 0:
        clr = Colors.teal[700];
        secondClr = Colors.deepPurple[700];
        break;
      case 1:
        clr = Colors.teal[900];
        secondClr = Colors.deepPurple;
        break;
      case 2:
        clr = Colors.deepPurple;
        secondClr = Colors.teal;
        break;
      case 3:
        clr = Colors.deepPurple[700];
        secondClr = Colors.teal[700];
        break;
    }
    return [clr, secondClr];
  }
}
