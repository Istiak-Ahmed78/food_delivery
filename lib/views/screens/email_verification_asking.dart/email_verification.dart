import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/views/screens/auth_screens/auth_sensitive_screen.dart';
import 'package:food_delivery/views/shared_widgets/shared_widgets.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:food_delivery/views/styles/paddings.dart';

class VerifyUserEmail extends StatelessWidget {
  const VerifyUserEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(Dimentions.largeDimention),
        height: _size.height,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                  vertical: Dimentions.mediamDimention),
              height: _size.height * 0.2,
              width: _size.width * 0.6,
              decoration: const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(Images.verifyEmail))),
            ),
            const Text(
              'Verify your email',
              style: TextStyle(
                  color: CResources.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: Dimentions.mediamDimention),
            ),
            const SizedBox(
              height: Dimentions.largeDimention,
            ),
            const Text(
              'For verification purpose,\n we\'ve sent an email. Please check your email \n and follow the instructiins included in the email',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: Strings.notosansFontFamilly),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: Dimentions.smallDimention),
              child: DefaultButton(
                child: const Text(
                  'Ok',
                  style: TextStyle(
                      color: CResources.white,
                      fontFamily: Strings.notosansFontFamilly),
                ),
                buttonColor: CResources.orange,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AuthSensitiveScreen()),
                      (route) => false);
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
