import 'package:flutter/material.dart';

class ProfileLecturer extends StatefulWidget {
  const ProfileLecturer({super.key});

  @override
  State<ProfileLecturer> createState() => _ProfileLecturerState();
}

class _ProfileLecturerState extends State<ProfileLecturer> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Profile Lecturer"),
    );
  }
}