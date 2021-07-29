import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/state_management/auth_providers.dart';
import 'package:food_delivery/state_management/cart_list_state.dart';
import 'package:food_delivery/state_management/favorite_list_state.dart';
import 'package:food_delivery/state_management/tab_index.dart';
import 'package:food_delivery/utils/shared_prefer.dart';
import 'package:provider/provider.dart';
import 'di_containers.dart' as di;
import 'state_management/order_process_state.dart';
import 'views/screens/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => di.services<CartListState>(),
      ),
      ChangeNotifierProvider(
          create: (context) => di.services<FavoriteFoodItems>()),
      ChangeNotifierProvider(create: (context) => di.services<TabIndex>()),
      ChangeNotifierProvider(create: (context) => di.services<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => OrderProcessState()),
      ChangeNotifierProvider(create: (context) => SharedPreProvider()),
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
      home: const SpleshScreen(),
    );
  }
}
