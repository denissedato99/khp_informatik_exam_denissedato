import 'package:flutter/material.dart';

class MainScreenViewModel with ChangeNotifier {
   int bottomTabIndex = 0;

  set setBottomNavTabIndex(int index) {
    bottomTabIndex = index;
    notifyListeners();
  }
  

}