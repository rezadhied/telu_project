import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/screens/lecturer/home_lecturer.dart';
import 'package:telu_project/screens/lecturer/inbox_lecturer.dart';
import 'package:telu_project/screens/lecturer/my_project_lecturer.dart';
import 'package:telu_project/screens/lecturer/profile_lecturer.dart';
import 'package:telu_project/screens/student/home_student.dart';
import 'package:telu_project/screens/student/inbox_student.dart';
import 'package:telu_project/screens/student/my_project_student.dart';
import 'package:telu_project/screens/student/profile_student.dart';
import 'package:telu_project/screens/lecturer/partials/myProject/member_profile.dart';


class MainApp extends StatefulWidget {
  final int selectedIndex;

  const MainApp(
      {super.key, this.selectedIndex = 0});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late int _selectedIndex;
  late bool _isStudent;
  late dynamic prefs;
  List<Widget> _widgetOptions = [];
  bool _isLoading = true;

  @override
  void initState(){
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _loadPreferences();
  }

  void _loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _isStudent = prefs.getString("isStudent") == "true";
      _widgetOptions = _isStudent
          ? <Widget>[ // Student
              HomeStudent(),
              MyProjectStudent(),
              InboxStudent(),
              ProfileStudent(),
            ]
          : <Widget>[ // Lecturer
              HomeLecturer(),
              MyProjectLecturer(),
              InboxLecturer(),
              ProfileLecturer(),
            ];
      _isLoading = false;
    });
  }

  late BuildContext scaffoldContext;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Builder(
        builder: (BuildContext context) {
          scaffoldContext = context;
          if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SafeArea(
              child: _widgetOptions.elementAt(_selectedIndex),
            );
          }
        },
      ),
      bottomNavigationBar: (Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work),
              label: 'My Project',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inbox),
              label: 'Inbox',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: 'Profile',
            ),
          ],
          backgroundColor: AppColors.white,
          currentIndex: _selectedIndex,
          unselectedItemColor: AppColors.blackAlternative.withOpacity(0.4),
          selectedItemColor: AppColors.primary,
          onTap: _onItemTapped,
        ),
      )),
    );
  }
}
