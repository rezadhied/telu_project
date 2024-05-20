import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/screens/login/component/button_component.dart';
import 'package:telu_project/screens/login/component/text_field_component.dart';
import 'package:telu_project/screens/login/signin.dart';
import 'package:telu_project/screens/my_project_screen.dart';
import 'package:telu_project/screens/app_navigation_bar.dart';

class RegisterStudent extends StatefulWidget {
  const RegisterStudent({super.key});

  @override
  State<RegisterStudent> createState() => _RegisterStudentState();
}

class _RegisterStudentState extends State<RegisterStudent> {
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
                  const TextFieldComponent(hintText: "Student ID Number"),
                  const TextFieldComponent(hintText: "Phone Number"),
                  const TextFieldComponent(hintText: "Faculty"),
                  const TextFieldComponent(hintText: "Major"),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.white,
                          backgroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.black),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        ),
                        onPressed: () {
                          final snackBar = SnackBar(
                            content:
                                const Text('Alhamdulillah! Akun telah dibuat'),
                            action: SnackBarAction(
                              label: 'Yes',
                              onPressed: () {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((timeStamp) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AppNavigationBar(
                                                isStudent: true)),
                                    (route) => false,
                                  );
                                });
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
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


 // Container(
                  //   margin: const EdgeInsets.only(top: 20),
                  //   child: SizedBox(
                  //     height: 50,
                  //     width: double.infinity,
                  //     child: OutlinedButton(
                  //       style: OutlinedButton.styleFrom(
                  //         foregroundColor: AppColors.white,
                  //         backgroundColor: AppColors.primary,
                  //         side: const BorderSide(color: AppColors.black),
                  //         shape: const RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.all(Radius.circular(12)),
                  //         ),
                  //         padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  //       ),
                  //       onPressed: () {
                  //         WidgetsBinding.instance
                  //             .addPostFrameCallback((timeStamp) {
                  //           Navigator.of(context).pushAndRemoveUntil(
                  //             MaterialPageRoute(
                  //               builder: (context) => const AppNavigationBar(
                  //                 isStudent: true,
                  //               ),
                  //             ),
                  //             (route) => false,
                  //           );
                  //         });
                  //       },
                  //       child: Text(
                  //         'Sign Up',
                  //         style: GoogleFonts.inter(
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),