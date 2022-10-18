import 'package:flutter/material.dart';

class GamePoints extends ChangeNotifier {
  int _points = 25;
  int get points => _points;

  void pointsAdd(int value) {
    _points = _points + value;
    notifyListeners();
  }
}
