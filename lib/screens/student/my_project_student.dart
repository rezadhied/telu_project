import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/screens/lecturer/partials/myProject/create_project_screen.dart';
import 'package:telu_project/screens/lecturer/partials/myProject/project_screen.dart';
import 'package:provider/provider.dart';
import 'package:telu_project/screens/test.dart';

class MyProjectStudent extends StatefulWidget {
  const MyProjectStudent({super.key});

  @override
  State<MyProjectStudent> createState() => _MyProjectStudentState();
}

class _MyProjectStudentState extends State<MyProjectStudent> {
  
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("My Project Student"),
    );
  }
}
