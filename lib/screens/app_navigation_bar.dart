import 'package:flutter/material.dart';
import 'package:telu_project/colors.dart';
import 'package:telu_project/navigation_state.dart';
import 'package:telu_project/screens/home_screen.dart';
import 'package:telu_project/screens/my_project_screen.dart';
import 'package:telu_project/screens/request_detail.dart';
import 'package:telu_project/screens/user_profile.dart';
import 'package:provider/provider.dart';

class AppNavigationBar extends StatefulWidget {
  final bool isStudent;

  const AppNavigationBar({super.key, required this.isStudent});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  int _selectedIndex = 0;
  late BuildContext scaffoldContext;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    MyProject(),
    Center(child: Text("Inbox", textAlign: TextAlign.center)),
    Center(child: Text("Profile", textAlign: TextAlign.center)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Builder(
        builder: (BuildContext context) {
          scaffoldContext = context;
          return SafeArea(
            child: _widgetOptions.elementAt(_selectedIndex),
          );
        },
      ),
      bottomNavigationBar: Consumer<NavigationState>(
        builder: (context, navigationState, _) => navigationState.showNavBar
            ? Container(
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
                  unselectedItemColor:
                      AppColors.blackAlternative.withOpacity(0.4),
                  selectedItemColor: AppColors.primary,
                  onTap: _onItemTapped,
                ),
              )
            : const SizedBox(), // Ensure that a Widget is returned
      ),
    );
  }
}
