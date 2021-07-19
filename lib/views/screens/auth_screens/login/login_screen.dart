import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/state_management/auth_providers.dart';
import 'package:food_delivery/utils/form_validation.dart';
import 'package:food_delivery/utils/mathods.dart';
import 'package:food_delivery/views/screens/nav_bar/nav_bar.dart';
import 'package:food_delivery/views/shared_widgets/shared_widgets.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:food_delivery/views/styles/paddings.dart';
import 'package:provider/provider.dart';
import '../../../../constants.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final loginFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: _size.width * 0.1),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: _size.height * 0.35,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Images.logInDeliveryMan))),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: ColorResources.black,
                          fontFamily: Strings.notosansFontFamilly,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimentions.largeDimention),
                    ),
                  ),
                  Form(
                      key: loginFormKey,
                      child: Column(
                        children: [
                          DefaultFormFlield(
                            controller: emailController,
                            hintText: 'Your email',
                            validator: FormValidation.validateEmail,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: Dimentions.mediamDimention),
                            child: DefaultFormFlield(
                                controller: passwordController,
                                hintText: 'Password',
                                isPassword: true,
                                validator: FormValidation.validatePassword),
                          ),
                          const SizedBox(
                            height: Dimentions.smallDimention,
                          ),
                          DefaultButton(
                            onPressed: authProvider.isLoading
                                ? null
                                : () async {
                                    if (loginFormKey.currentState!.validate()) {
                                      if (await authProvider
                                          .logInwithEmailAndPassword(
                                              emailController.text,
                                              passwordController.text)) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const NavBar()));
                                      } else {
                                        Mathods.showToast(
                                            toastMessage: 'Wrong credtial');
                                      }
                                    }
                                  },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(color: ColorResources.white),
                            ),
                            buttonColor: ColorResources.orange,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: _size.height * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Expanded(
                                  child: Divider(
                                    thickness: 1,
                                    color: ColorResources.grey,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    'Social Logings',
                                    style: TextStyle(
                                        color: ColorResources.black
                                            .withOpacity(0.6),
                                        fontFamily:
                                            Strings.notosansFontFamilly),
                                  ),
                                ),
                                const Expanded(
                                  child: Divider(
                                    thickness: 1,
                                    color: ColorResources.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  child: const SocilLogInAvater(
                                      backGroundColor: Colors.pinkAccent,
                                      backGroundImage: Images.googleLogo),
                                  onTap: () async {
                                    if (await authProvider.signInWithGoogle()) {
                                      print('User authenicated');
                                    }
                                  },
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  child: const SocilLogInAvater(
                                      backGroundColor: ColorResources.blue,
                                      backGroundImage: Images.facebookLogo),
                                  onTap: () {},
                                )
                              ]),
                          const SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Don\'t have an account? ',
                                  style: TextStyle(
                                      color: ColorResources.black
                                          .withOpacity(0.7))),
                              TextSpan(
                                text: 'SignUp',
                                style: const TextStyle(
                                    fontFamily: Strings.notosansFontFamilly,
                                    fontWeight: FontWeight.bold,
                                    color: ColorResources.blueAccent),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('Let me sign up');
                                  },
                              ),
                            ]),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SocilLogInAvater extends StatelessWidget {
  final String backGroundImage;
  final Color backGroundColor;
  const SocilLogInAvater(
      {Key? key, required this.backGroundColor, required this.backGroundImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundImage: AssetImage(backGroundImage),
      backgroundColor: backGroundColor.withOpacity(0.4),
    );
  }
}
