import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:telu_project/screens/home_screen.dart';
import 'package:telu_project/screens/profile_user.dart';
import 'package:telu_project/screens/project_edit.dart';
import 'package:telu_project/screens/project_join.dart';

import 'package:telu_project/screens/login/welcome_screen.dart';
import 'package:telu_project/screens/my_project_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:telu_project/screens/project_list.dart';
import 'package:telu_project/screens/project_screen.dart';
import 'package:telu_project/screens/request_detail.dart';

void main() {
  Intl.defaultLocale = 'id';
  initializeDateFormatting().then((_) => runApp(const MyApp()));
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
      home: JoinProject(),
    );
  }
}
