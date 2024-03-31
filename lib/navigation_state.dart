import 'package:flutter/material.dart';

class NavigationState extends ChangeNotifier {
  bool _showNavBar = true;

  bool get showNavBar => _showNavBar;

  void toggleNavBar(bool value) {
    _showNavBar = value;
    print("show navbar = $_showNavBar");
    notifyListeners();
  }
}
