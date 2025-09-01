import 'package:flutter/material.dart';

class BottomNavBarServices with ChangeNotifier {
  int _pageView = 0;
  int get pageView => _pageView;
  void setIndex(int index) {
    _pageView = index;
    notifyListeners();
  }
}
