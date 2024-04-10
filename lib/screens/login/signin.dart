import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/class/User.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/screens/app_navigation_bar.dart';
import 'package:telu_project/screens/login/component/button_component.dart';
import 'package:telu_project/screens/login/component/text_field_component.dart';
import 'package:telu_project/screens/login/register_option.dart';
import 'package:provider/provider.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:telu_project/screens/my_project_screen.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String email = "mzakyf@telkomuniversity.ac.id";
  String password = "123";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: Container(
              margin: const EdgeInsets.fromLTRB(30, 20, 30, 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back.",
                    style: GoogleFonts.inter(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: AppColors.blackAlternative),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 7),
                    child: Text("Let’s sign you in",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                          color: AppColors.black,
                        )),
                  ),
                  TextFieldComponent(
                    hintText: "Username or Email",
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  TextFieldComponent(
                    hintText: "Password",
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  const ButtonComponent(
                      buttonText: 'Sign in', targetPage: MyProject()),
                  ElevatedButton(
                      onPressed: () {
                        _loginUser(email, password); // Call login function
                      },
                      child: Text('signin')),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Dont have a account yet? ',
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.blackAlternative)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterOption(), // Replace YourSignInPage with the page you want to navigate to
                            ),
                          );
                        },
                        child: Text(
                          'Create an account ',
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ],
              ))),
    );
  }
}

void _loginUser(String email, String password) async {
  try {
    final Map<String, dynamic> responseData = await loginUser(email, password);
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
    await SessionManager().set("user", user);
    print(user.toString());
    User u = User.fromJson(await SessionManager().get("user"));
    print(u.firstName);
  } catch (e) {
    print('Login failed: $e');
  }
}

Future<Map<String, dynamic>> loginUser(String email, String password) async {
  const String apiUrl = 'http://localhost:5000/login';

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
