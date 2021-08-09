import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/state_management/order_process_state.dart';
import 'package:food_delivery/utils/methods.dart';
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
        backgroundColor: CResources.white,
        elevation: 0.0,
        title: const Text(
          'Checkout',
          style: TextStyle(
              color: CResources.red, fontFamily: Strings.notosansFontFamilly),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: CResources.black,
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
              style: TextStyle(
                  color: CResources.grey,
                  fontFamily: Strings.notosansFontFamilly),
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
                    color: CResources.white,
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
                    color: CResources.orange,
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
                            Methods.showLoadingIndicator(
                                context: context, workTodo: pay());
                            showToast(context, 'Succesfully checked out');

                            Future.delayed(const Duration(seconds: 2), () {
                              setState(() {
                                isPressed = false;
                              });
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const NavBar()));
                            });
                          },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        const Text(
                          'Pay',
                          style: TextStyle(
                              color: CResources.white,
                              fontFamily: Strings.notosansFontFamilly),
                        ),
                        Text(
                          '\$$checkOutAmount',
                          style: const TextStyle(
                              color: CResources.white,
                              fontFamily: Strings.notosansFontFamilly),
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

  Future<void> pay() async {
    await Provider.of<OrderProcessState>(context, listen: false)
        .compleOrderingProccess(context);
  }
}
