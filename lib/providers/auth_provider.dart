import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telu_project/class/User.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> loginUser(String email, String password, String url) async {
    try {
      final Map<String, dynamic> responseData =
          await doLogin(email, password, url);
      User user = User(
        userID: responseData['user']['userID'] ?? 0,
        firstName: responseData['user']['firstName'] ?? '',
        lastName: responseData['user']['lastName'] ?? '',
        phoneNumber: responseData['user']['phoneNumber'] ?? '',
        photoProfileUrl: responseData['user']['photoProfileUrl'] ?? '',
        photoProfileImage: responseData['user']['photoProfileImage'] ?? '',
        email: responseData['user']['email'] ?? '',
        gender: responseData['user']['gender'] ?? '',
        lectureCode: responseData['user']['lectureCode'] ?? '',
        facultyCode: responseData['user']['facultyCode'] ?? '',
        facultyName: responseData['user']['facultyName'] ?? '',
        majorCode: responseData['user']['majorCode'] ?? '',
        majorName: responseData['user']['majorName'] ?? '',
        kelas: responseData['user']['kelas'] ?? '',
        role: responseData['user']['role'] ?? '',
      );
      await storeUserData(user);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("userId", user.userID.toString());

      _errorMessage = '';
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to login';
      notifyListeners();
      return false;
    }
  }

  Future<Map<String, dynamic>> doLogin(
      String email, String password, String url) async {
    String apiUrl = '$url/login';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, String> body = {
      'email': email,
      'password': password,
    };

    final response = await http.post(Uri.parse(apiUrl),
        headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  Future<void> storeUserData(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    prefs.setString('userData', userJson);
  }

  Future<User?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('userData');
    if (userJson != null) {
      Map<String, dynamic> userDataMap = jsonDecode(userJson);
      return User.fromJson(userDataMap);
    }
    return null;
  }

  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }
}
