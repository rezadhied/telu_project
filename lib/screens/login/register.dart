import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/screens/login/component/button_component.dart';
import 'package:telu_project/screens/login/component/text_field_component.dart';
import 'package:telu_project/screens/login/register_lecturer.dart';
import 'package:telu_project/screens/login/register_student.dart';
import 'package:telu_project/screens/login/signin.dart';

class Register extends StatefulWidget {
  final bool isStudent;

  const Register({super.key, required this.isStudent});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                  const TextFieldComponent(hintText: "Username or Email"),
                  const TextFieldComponent(hintText: "Password"),
                  const TextFieldComponent(hintText: "Confirm Password"),
                  ButtonComponent(
                    buttonText: 'Next',
                    targetPage: widget.isStudent
                        ? const RegisterStudent()
                        : const RegisterLecturer(),
                  ),
                  const Spacer(),
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
