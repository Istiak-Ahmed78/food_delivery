import 'package:flutter/material.dart';
import 'package:food_delivery/state_management/auth_providers.dart';
import 'package:food_delivery/state_management/cart_list_state.dart';
import 'package:food_delivery/utils/shared_prefer.dart';
import 'package:food_delivery/views/screens/auth_screens/login/login_screen.dart';
import 'package:food_delivery/views/screens/intro_page/intro_screen.dart';
import 'package:food_delivery/views/screens/nav_bar/nav_bar.dart';
import 'package:provider/provider.dart';

class AuthSensitiveScreen extends StatelessWidget {
  const AuthSensitiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSignedIn = Provider.of<AuthProvider>(
      context,
    ).isLoggedIn();

    if (isSignedIn) {
      return Provider.of<SharedPreProvider>(
        context,
      ).isFirstLaunch
          ? const IntroPage()
          : const NavBar();
    } else {
      return const LogInScreen();
    }
  }
}
