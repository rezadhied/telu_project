import 'dart:io';

import 'package:flutter/material.dart';

class ApiUrlProvider with ChangeNotifier {
  String _baseUrl = '';

  ApiUrlProvider() {
    _initializeBaseUrl();
  }

  String get baseUrl => _baseUrl;

  void _initializeBaseUrl() {
    // if (Platform.isAndroid) {
    //   _baseUrl = 'http://10.0.2.2:5000';
    // } else {
    //   _baseUrl = 'http://localhost:5000';
    // }
    _baseUrl = 'https://srv531466.hstgr.cloud';
    notifyListeners();
  }
}
