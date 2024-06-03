import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/components/button_component.dart';
import 'package:telu_project/components/text_field_component.dart';
import 'package:telu_project/providers/api_url_provider.dart';
import 'package:telu_project/screens/login/register_detail.dart';
import 'package:telu_project/screens/login/signin.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  final bool isStudent;

  const Register({super.key, required this.isStudent});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  String loginErrorMessage = "";

  List<dynamic> dataFacultyMajor = [];

  Future<void> fetchFacultyMajor() async {
    try {
      String url = Provider.of<ApiUrlProvider>(context, listen: false).baseUrl;
      final response = await http.get(Uri.parse('$url/faculty-major'));
      print(response.body);
      dataFacultyMajor = json.decode(response.body);
    } catch (e) {
      print("Error :$e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFacultyMajor();
  }

  @override
  void dispose() {
    username.text = "";
    password.text = "";
    confirmPassword.text = "";
    loginErrorMessage = "";

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
              margin: const EdgeInsets.fromLTRB(30, 20, 30, 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Start the journey.",
                          style: GoogleFonts.inter(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              color: AppColors.blackAlternative),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Text("Let’s create an account",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(
                                fontSize: 24,
                                fontWeight: FontWeight.w300,
                                color: AppColors.black,
                              )),
                        ),
                        TextFieldComponent(
                          hintText: "Username",
                          textEditingController: username,
                          onChanged: (value) {
                            setState(() {
                              username.text = value;
                            });
                          },
                        ),
                        TextFieldComponent(
                          hintText: "Password",
                          textEditingController: password,
                          onChanged: (value) {
                            setState(() {
                              password.text = value;
                            });
                          },
                        ),
                        TextFieldComponent(
                          hintText: "Confirm Password",
                          textEditingController: confirmPassword,
                          onChanged: (value) {
                            setState(() {
                              confirmPassword.text = value;
                            });
                          },
                        ),
                        loginErrorMessage.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  loginErrorMessage,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        ButtonComponent(
                          buttonText: 'Next',
                          targetPage: RegisterDetail(
                            email: username.text +
                                (widget.isStudent
                                    ? "@student.telkomuniversity.ac.id"
                                    : "@telkomuniversity.ac.id"),
                            password: password.text,
                            dataFacultyMajor: dataFacultyMajor,
                            isStudent: widget.isStudent,
                          ),
                          data: {
                            "username": username.text,
                            "password": password.text,
                            "confirmPassword": confirmPassword.text
                          },
                          action: "reg-1",
                          callback: (value) {
                            setState(() {
                              loginErrorMessage = value;
                              if (value == "") {
                                loginErrorMessage = "";
                                username.text = "";
                                password.text = "";
                                confirmPassword.text = "";
                              }
                            });
                          },
                        ),
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account? ',
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
                                  const Signin(), // Replace YourSignInPage with the page you want to navigate to
                            ),
                          );
                        },
                        child: Text(
                          'Sign in',
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
