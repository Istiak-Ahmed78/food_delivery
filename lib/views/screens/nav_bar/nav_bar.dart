import 'package:flutter/material.dart';
import 'package:food_delivery/state_management/tab_index.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:provider/provider.dart';
import 'nav_bar_items.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: 'l1',
        backgroundColor: CResources.orange,
        onPressed: () {
          Provider.of<TabIndex>(context, listen: false).setIndex(2);
        },
        child: const Icon(Icons.home),
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: Provider.of<TabIndex>(context).currentIndex,
            children: [
              for (final navItem in BottomNavItem.bottomNavItemList)
                navItem.screen,
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavigationBar(
              selectedItemColor: CResources.redAccent,
              unselectedItemColor: CResources.grey,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              currentIndex: Provider.of<TabIndex>(context).currentIndex,
              onTap: (index) {
                Provider.of<TabIndex>(context, listen: false).setIndex(index);
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
