import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telu_project/firebase_options.dart';
import 'package:telu_project/helper/sharedPreferences.dart';
import 'package:telu_project/providers/api_url_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:telu_project/screens/login/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:telu_project/providers/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:telu_project/screens/main_app.dart';
import 'firebase_options.dart';

String? token;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  importance: Importance.high,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper().init();
  await SharedPreferencesHelper().setString("myProjectUpdate", "true");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FlutterLocalNotificationsPlugin()
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
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
  bool isLoading = true;
  Widget defaultHome = WelcomePage();

  late FirebaseMessaging _messaging;
  @override
  void initState() {
    super.initState();
    _messaging = FirebaseMessaging.instance;
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    FlutterLocalNotificationsPlugin().initialize(initializationSettings);
    getToken();

    checkUserId();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        FlutterLocalNotificationsPlugin().show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                icon: "@mipmap/ic_launcher",
              ),
            ));
      }
    });

    _messaging.subscribeToTopic('projects');
  }

  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
  }

  Future<void> checkUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    if (userId != null) {
      setState(() {
        defaultHome = const MainApp(
          selectedIndex: 0,
        );
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return CircularProgressIndicator();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Telyu Project',
      home: defaultHome,
    );
  }
}
