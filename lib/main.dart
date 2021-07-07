import 'package:flutter/material.dart';
import 'package:food_delivery/state_management/cart_list_state.dart';
import 'views/screens/maps_explorer/maps_explorer.dart';
import 'views/screens/nav_bar/nav_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => CartList(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: const MapsExplorer(),
    );
  }
}
