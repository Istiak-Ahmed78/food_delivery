import 'package:flutter/material.dart';
import 'package:food_delivery/utils/shared_prefer.dart';
import 'package:food_delivery/views/screens/nav_bar/nav_bar.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final List<PageViewModel> introPages = [
    PageViewModel(
        title: 'Place order easily',
        body: 'Yes, It\'s so easy to place your order then before.',
        image: Center(child: Lottie.asset('assets/lottie/order_easily.json'))),
    PageViewModel(
        title: 'Food at low price',
        body: 'You will get food at low price.Just try it.',
        image: Center(child: Lottie.asset('assets/lottie/food_at_low.json'))),
    PageViewModel(
        title: 'Fast delivery',
        body: 'Get your order fast. No delay',
        image: Center(child: Lottie.asset('assets/lottie/fast_delivery.json')))
  ];
  @override
  void initState() {
    super.initState();
    SharedPre sharedPre = SharedPre();
    sharedPre.setIntroBoolTrue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: introPages,
        showDoneButton: true,
        done: const Text('Done'),
        showNextButton: true,
        showSkipButton: true,
        skip: const Text('Skip'),
        next: const Text('Next'),
        onDone: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const NavBar()));
        },
      ),
    );
  }
}
