import 'package:flutter/material.dart';
import 'package:food_delivery/utils/shared_prefer.dart';
import 'package:food_delivery/views/screens/intro_page/intro_screen.dart';
import 'package:food_delivery/views/screens/nav_bar/nav_bar.dart';
import 'package:lottie/lottie.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({Key? key}) : super(key: key);

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  bool isNotFirstLauch = false;
  @override
  void initState() {
    super.initState();
    getFirstLauchData();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  isNotFirstLauch ? const NavBar() : const NavBar()));
    });
  }

  void getFirstLauchData() async {
    SharedPre sharedPre = SharedPre();
    isNotFirstLauch = await sharedPre.getIntroBool() ?? false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: Text('Loading'),
        child: Lottie.asset('assets/lottie/food_lottie.json'),
      ),
    );
  }
}
