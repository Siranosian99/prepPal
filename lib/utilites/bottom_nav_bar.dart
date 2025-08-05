import 'package:flutter/material.dart';
import 'package:preppal/utilites/navigation_mixin.dart';


import '../consts/texts.dart';
class BottomNavBar extends StatefulWidget {
  final Widget child;
  const BottomNavBar({super.key,required this.child});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>with NavigatorMixin {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    navigateTo(index);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:BottomNavigationBar(
          currentIndex: _selectedIndex, // current selected index
          onTap: _onItemTapped,         // change index on tap
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Guides',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.heart_broken_rounded),
              label: 'Favourites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ]),
      body: widget.child,
    );
  }
}
