import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/screens/main_app.dart';
import 'package:telu_project/components/button_component.dart';
import 'package:telu_project/components/text_field_component.dart';
import 'package:telu_project/screens/login/signin.dart';
import 'package:telu_project/screens/student/my_project_student.dart';

class RegisterLecturer extends StatefulWidget {

  final String email;
  final String password; 
  final List<dynamic> dataFacultyMajor;

  const RegisterLecturer({super.key, required this.email, required this.password, required this.dataFacultyMajor});

  @override
  State<RegisterLecturer> createState() => _RegisterLecturerState();
}

class _RegisterLecturerState extends State<RegisterLecturer> {

  late List<dynamic> dataFacultyMajor;
  List<dynamic> dataMajor = [];

  @override
  void initState() {
    super.initState();
    dataFacultyMajor = widget.dataFacultyMajor;
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
                    targetPage: MainApp(),
                    isReplacementPush: true,
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
