import 'package:facebook_clone/features/home/screens/feed_screen.dart';
import 'package:facebook_clone/features/menu/screens/menu_screen.dart';
import 'package:facebook_clone/features/test/test_screen.dart';
import 'package:facebook_clone/features/test/test_screen2.dart';
import 'package:facebook_clone/features/test/test_screen3.dart';
import 'package:facebook_clone/theme/theme.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  const BottomTabs({Key? key}) : super(key: key);

  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    FeedScreen(),
    TestScreen(),
    TestScreen2(),
    TestScreen3(),
    Text(
      'Index 1: Business',
    ),
    MenuScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        iconSize: 30,
        backgroundColor: ClassTheme.drawerColor,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_outline,
            ),
            label: 'Dating',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dehaze),
            label: 'Menu',
          ),
        ],
      ),
    );
  }
}
