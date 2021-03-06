import 'package:flutter/material.dart';
import 'package:food_delivery/views/screens/nav_bar_tabs/tabs.dart';

class BottomNavItem {
  final Widget screen;
  final String title;
  final IconData icon;

  BottomNavItem(
      {required this.screen, required this.title, required this.icon});
  static List<BottomNavItem> bottomNavItemList = [
    BottomNavItem(
        screen: const TracOrders(),
        title: 'Shopping',
        icon: Icons.local_shipping),
    BottomNavItem(
        screen: const AccountTab(), title: 'Account', icon: Icons.person),
    BottomNavItem(screen: const HomeTab(), title: 'Home', icon: Icons.home),
    BottomNavItem(
        screen: const FoodTab(), title: 'Food', icon: Icons.fastfood_sharp),
    BottomNavItem(
        screen: const WishListTab(), title: 'Wish List', icon: Icons.favorite),
  ];
}
