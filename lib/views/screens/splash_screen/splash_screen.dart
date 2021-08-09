import 'package:flutter/material.dart';
import 'package:food_delivery/state_management/cart_list_state.dart';
import 'package:food_delivery/utils/shared_prefer.dart';
import 'package:food_delivery/views/screens/auth_screens/auth_sensitive_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({Key? key}) : super(key: key);

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      await Provider.of<SharedPreProvider>(context, listen: false)
          .getIntroBool();
      await Provider.of<CartListState>(context, listen: false)
          .getCartListProducts();
      // services<FirestoreRepos>()
      //     .getShoppingCartList(services<AuthRepos>().getCurrentUser()!.uid);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const AuthSensitiveScreen()),
          (route) => false);
    });
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
