import 'package:flutter/material.dart';
import 'package:food_delivery/state_management/cart_list_state.dart';
import 'package:food_delivery/state_management/favorite_list_state.dart';
import 'package:food_delivery/state_management/tab_index.dart';
import 'views/screens/checkout/check_out_screen.dart';
import 'views/screens/maps_explorer/maps_explorer.dart';
import 'views/screens/nav_bar/nav_bar.dart';
import 'package:provider/provider.dart';

import 'views/screens/order_details/order_details.dart';
import 'views/screens/settings_page/settings_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => CartList(),
      ),
      ChangeNotifierProvider(create: (context) => TabIndex()),
      ChangeNotifierProvider(create: (context) => FavoriteFoodItems())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: const NavBar(),
    );
  }
}
