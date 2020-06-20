import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:uniassist/screens/auth.screen.dart';
import 'package:uniassist/screens/profile.screen.dart';
import 'package:uniassist/screens/tasks.screen.dart';
import 'package:uniassist/screens/timer.screen.dart';
import 'package:uniassist/utils/constants.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectedIndex = 0;

  var menuItems = [
    [
      Feather.circle,
      'Timer',
      TimerScreen(),
    ],
    [
      Feather.list,
      'Tasks',
      TasksScreen(),
    ],
    [
      Feather.user,
      'Account',
      ProfileScreen(),
    ],
  ];

  select(int idx) {
    setState(() {
      _selectedIndex = idx;
    });
  }

  buildNavItems() {
    List<BottomNavigationBarItem> navItems = [];

    for (var m in menuItems) {
      navItems.add(
        BottomNavigationBarItem(
          icon: Icon(
            m[0],
          ),
          title: Text(m[1]),
        ),
      );
    }

    return navItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: menuItems[_selectedIndex][2],
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: kHeight(context) * .01),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: kDarkGray,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (int idx) => select(idx),
          backgroundColor: Colors.black,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: buildNavItems(),
        ),
      ),
    );
  }
}
