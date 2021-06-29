import 'package:flutter/material.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'nav_bar_items.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _currentIndex = 2;
          });
        },
        child: const Icon(Icons.home),
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: [
              for (final navItem in BottomNavItem.bottomNavItemList)
                navItem.screen,
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavigationBar(
              selectedItemColor: kRedAccent,
              unselectedItemColor: kGrey,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                for (final item in BottomNavItem.bottomNavItemList)
                  BottomNavigationBarItem(
                      icon: Icon(item.icon), label: item.title)
              ],
            ),
          )
        ],
      ),
    );
  }
}
