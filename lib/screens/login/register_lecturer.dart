import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/screens/app_navigation_bar.dart';
import 'package:telu_project/screens/login/component/button_component.dart';
import 'package:telu_project/screens/login/component/text_field_component.dart';
import 'package:telu_project/screens/login/signin.dart';
import 'package:telu_project/screens/my_project_screen.dart';

class RegisterLecturer extends StatefulWidget {
  const RegisterLecturer({super.key});

  @override
  State<RegisterLecturer> createState() => _RegisterLecturerState();
}

class _RegisterLecturerState extends State<RegisterLecturer> {
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
                    child: Text("Fill your personal info",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                          color: AppColors.black,
                        )),
                  ),
                  const TextFieldComponent(hintText: "Name"),
                  const TextFieldComponent(hintText: "Gender"),
                  const TextFieldComponent(hintText: "Lecturer Code"),
                  const TextFieldComponent(hintText: "Phone Number"),
                  const TextFieldComponent(hintText: "Faculty"),
                  const TextFieldComponent(hintText: "Major"),
                  const ButtonComponent(
                    buttonText: 'Sign Up',
                    targetPage: AppNavigationBar(isStudent: false),
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
