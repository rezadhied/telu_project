import 'package:flutter/material.dart';

class InboxStudent extends StatefulWidget {
  const InboxStudent({super.key});

  @override
  State<InboxStudent> createState() => _InboxStudentState();
}

class _InboxStudentState extends State<InboxStudent> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Inbox Student"),
    );
  }
}