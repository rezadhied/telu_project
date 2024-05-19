import 'package:flutter/material.dart';

class HomeLecturer extends StatefulWidget {
  const HomeLecturer({super.key});

  @override
  State<HomeLecturer> createState() => _HomeLecturerState();
}

class _HomeLecturerState extends State<HomeLecturer> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Home Lecturer"),
    );
  }
}