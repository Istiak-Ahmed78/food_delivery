import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/state_management/cart_list_state.dart';
import 'package:food_delivery/views/screens/nav_bar/nav_bar.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:provider/provider.dart';
import 'components/components.dart';

class CheckoutScreen extends StatefulWidget {
  final double checkOutValue;
  const CheckoutScreen({Key? key, required this.checkOutValue})
      : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  double checkOutAmount = 0.0;
  bool isPressed = false;
  @override
  void initState() {
    super.initState();
    checkOutAmount = widget.checkOutValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0.0,
        title: const Text(
          'Checkout',
          style: TextStyle(color: kRed, fontFamily: kNotosans),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kBlack,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Headline(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Cart(),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Or Checkout With',
              style: TextStyle(color: kGrey, fontFamily: kNotosans),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  MaterialButton(
                    onPressed: isPressed ? null : () {},
                    height: 50,
                    minWidth: double.infinity,
                    color: kWhite,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Container(
                      height: 40,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/paypal.png'))),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  MaterialButton(
                    color: kOrange,
                    minWidth: double.infinity,
                    height: 50,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    onPressed: isPressed
                        ? null
                        : () {
                            setState(() {
                              isPressed = true;
                              checkOutAmount = 0.0;
                            });
                            showToast(context, 'Succesfully checked out');
                            Provider.of<CartList>(context, listen: false)
                                .chechedOut();
                            Future.delayed(const Duration(seconds: 2), () {
                              setState(() {
                                isPressed = false;
                              });
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const NavBar()));
                            });
                          },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        const Text(
                          'Pay',
                          style:
                              TextStyle(color: kWhite, fontFamily: kNotosans),
                        ),
                        Text(
                          '\$$checkOutAmount',
                          style: const TextStyle(
                              color: kWhite, fontFamily: kNotosans),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
