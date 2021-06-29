import 'package:flutter/material.dart';
import 'package:food_delivery/views/screens/nav_bar_tabs/tabs.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavItem {
  final Widget screen;
  final String title;
  final IconData icon;

  BottomNavItem(
      {required this.screen, required this.title, required this.icon});
  static List<BottomNavItem> bottomNavItemList = [
    BottomNavItem(
        screen: const NotificationTab(),
        title: 'Notifications',
        icon: Icons.notifications),
    BottomNavItem(
        screen: const AccountTab(), title: 'Account', icon: Icons.person),
    BottomNavItem(screen: const HomeTab(), title: 'Home', icon: Icons.home),
    BottomNavItem(
        screen: const FoodTab(), title: 'Food', icon: Icons.fastfood_sharp),
    BottomNavItem(
        screen: const WishListTab(),
        title: 'Wish List',
        icon: FontAwesomeIcons.heart),
  ];
}
