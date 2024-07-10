import 'package:flutter/material.dart';

class StreaksViewModel extends ChangeNotifier {
  int _streaks = 0;

  int get streaks => _streaks;

  void syncStreaks(int streaks) {
    _streaks = streaks;
    notifyListeners();
  }

  void incrementStreaks() {
    _streaks++;
    notifyListeners();
  }

  void resetStreaks() {
    _streaks = 0;
    notifyListeners();
  }
}
