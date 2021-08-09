import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery/state_management/auth_providers.dart';
import 'package:food_delivery/utils/form_validation.dart';
import 'package:food_delivery/utils/methods.dart';
import 'package:food_delivery/utils/repos/auth_repo.dart';
import 'package:food_delivery/views/screens/auth_screens/sign_up/sign_up_screen.dart';
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
  final logInKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormFieldState>();

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
            padding: EdgeInsets.symmetric(
                horizontal: _size.width * 0.1,
                vertical: Dimentions.largeDimention),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: _size.height * 0.3,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Images.logInDeliveryMan))),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimentions.soSmallDinmention),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: CResources.black,
                          fontFamily: Strings.notosansFontFamilly,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimentions.largeDimention),
                    ),
                  ),
                  Form(
                      key: logInKey,
                      child: Column(
                        children: [
                          DefaultFormFlield(
                            key: emailFormKey,
                            controller: emailController,
                            hintText: 'Your email',
                            validator: FormValidation.validateEmail,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: Dimentions.soSmallDinmention),
                            child: DefaultFormFlield(
                                controller: passwordController,
                                hintText: 'Password',
                                isPassword: true,
                                validator: FormValidation.validatePassword),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () async {
                                  if (emailController.text.isEmpty ||
                                      FormValidation.validateEmail(
                                              emailController.text) !=
                                          null) {
                                    Methods.emtyEmailWarning(context);
                                  } else {
                                    if (await authProvider
                                        .sendForgetPasswordMail(
                                            emailController.text)) {
                                      Methods.showToast(
                                          toastMessage: 'Email sent');
                                    } else {
                                      Methods.showToast(
                                          toastMessage: authProvider
                                              .firebaseErrorMessgase,
                                          duration: Toast.LENGTH_LONG);
                                    }
                                  }
                                },
                                child: const Text(
                                  'Forgot your password?',
                                  style: TextStyle(
                                      color: CResources.grey,
                                      fontStyle: FontStyle.italic),
                                )),
                          ),
                          const SizedBox(
                            height: Dimentions.smallDimention,
                          ),
                          DefaultButton(
                            onPressed: Provider.of<AuthProvider>(context)
                                    .isLoading
                                ? null
                                : () async {
                                    if (logInKey.currentState!.validate()) {
                                      if (await authProvider
                                          .logInwithEmailAndPassword(
                                              emailController.text,
                                              passwordController.text)) {
                                        print('Logging In');
                                        if (!authProvider.isEmailVarified(
                                            authProvider.currentUser!)) {
                                          Methods.showVerificationAskingDialog(
                                              context,
                                              authProvider.currentUser!);
                                        }
                                      } else {
                                        Methods.showToast(
                                            toastMessage: authProvider
                                                .firebaseErrorMessgase);
                                      }
                                    }
                                  },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(color: CResources.white),
                            ),
                            buttonColor: CResources.orange,
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
                                    color: CResources.grey,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    'Social Logings',
                                    style: TextStyle(
                                        color:
                                            CResources.black.withOpacity(0.6),
                                        fontFamily:
                                            Strings.notosansFontFamilly),
                                  ),
                                ),
                                const Expanded(
                                  child: Divider(
                                    thickness: 1,
                                    color: CResources.grey,
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
                                  onTap: Provider.of<AuthProvider>(context)
                                          .isLoading
                                      ? null
                                      : () async {
                                          await authProvider.signInWithGoogle();
                                        },
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  child: const SocilLogInAvater(
                                      backGroundColor: CResources.blue,
                                      backGroundImage: Images.facebookLogo),
                                  onTap: Provider.of<AuthProvider>(context)
                                          .isLoading
                                      ? null
                                      : () async {
                                          await authProvider
                                              .singnInWithFacebook();
                                        },
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
                                      color:
                                          CResources.black.withOpacity(0.7))),
                              TextSpan(
                                text: 'SignUp',
                                style: const TextStyle(
                                    fontFamily: Strings.notosansFontFamilly,
                                    fontWeight: FontWeight.bold,
                                    color: CResources.blueAccent),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const SignUpScreen()));
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
