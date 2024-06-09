import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telu_project/class/User.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/screens/main_app.dart';
import 'package:telu_project/components/button_component.dart';
import 'package:telu_project/components/text_field_component.dart';
import 'package:telu_project/screens/login/register_option.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String email = "";
  String password = "";
  bool isLoading = false;

  String loginErrorMessage = "";

  Future<void> loadLoginErrorMessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? errorMessage = prefs.getString('loginErrorMessage');
    setState(() {
      loginErrorMessage = errorMessage ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
        children: [
          Container(
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
                    isPassword: true,
                  ),
                  loginErrorMessage.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            loginErrorMessage,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        )
                      : SizedBox(),
                  ButtonComponent(
                    buttonText: 'Sign in',
                    targetPage: MainApp(),
                    isReplacementPush: true,
                    action: "signin",
                    data: {"email": email, "password": password},
                    callback: (value) {
                      setState(() {
                        loginErrorMessage = value;
                      });
                    },
                    callbackLogin: (value) {
                      setState(() {
                        loginErrorMessage = "";
                        isLoading = value;
                      });
                    },
                  ),
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
              )),
          isLoading
              ? Stack(
                  children: [
                    // BackdropFilter for the blur effect
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: Colors.black
                            .withOpacity(0.1), // Semi-transparent color
                      ),
                    ),
                    // Centered CircularProgressIndicator
                    Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
        ],
      )),
    );
  }
}
