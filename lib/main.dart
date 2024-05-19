import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:telu_project/providers/api_url_provider.dart';

import 'package:telu_project/screens/login/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:telu_project/providers/auth_provider.dart';

void main() async {
  Intl.defaultLocale = 'id';
  initializeDateFormatting().then((_) => runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => AuthProvider()),
            ChangeNotifierProvider(create: (context) => ApiUrlProvider()),
          ],
          child: const MyApp(),
        ),
      ));
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
