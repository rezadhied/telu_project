import 'package:flutter/material.dart';
import 'package:telu_project/screens/invite_student.dart';
import 'package:telu_project/screens/login/welcome_screen.dart';
import 'package:telu_project/screens/my_project_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Telyu Project',
      home: WelcomePage(),
    );
  }
}
