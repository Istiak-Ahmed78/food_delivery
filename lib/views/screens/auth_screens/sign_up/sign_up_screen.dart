import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/state_management/auth_providers.dart';
import 'package:food_delivery/utils/form_validation.dart';
import 'package:food_delivery/utils/mathods.dart';
import 'package:food_delivery/views/screens/auth_screens/login/login_screen.dart';
import 'package:food_delivery/views/screens/nav_bar/nav_bar.dart';
import 'package:food_delivery/views/shared_widgets/shared_widgets.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:food_delivery/views/styles/paddings.dart';
import 'package:provider/provider.dart';
import '../../../../constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signUpFormKey = GlobalKey<FormState>();
  double passwordStrenth = 0.0;
  String? password;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Dimentions.largeDimention,
              horizontal: Dimentions.mediamDimention),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: _size.height * 0.35,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(Images.cooking))),
            ),
            const Text(
              'SignUp',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: Strings.notosansFontFamilly,
                  fontSize: Dimentions.largeDimention),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimentions.mediamDimention),
              child: Form(
                  key: signUpFormKey,
                  child: Column(
                    children: [
                      DefaultFormFlield(
                        controller: emailController,
                        hintText: 'Your email',
                        validator: FormValidation.validateEmail,
                      ),
                      DefaultFormFlield(
                          controller: passwordController,
                          hintText: 'Enter a new password',
                          isPassword: true,
                          onChanged: (value) {
                            setState(() {
                              passwordStrenth =
                                  Mathods.getStrenthOfPassword(value);
                            });
                          },
                          validator: FormValidation.validatePassword),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: PasswordStrenthContainer(
                          passwordPersent: passwordStrenth,
                        ),
                      ),
                      ConfirmPasswordField(
                          controller: confirmPassword,
                          validator: (confirmPassword) {
                            return FormValidation.validateConfirmPassword(
                                confirmPassword == passwordController.text);
                          }),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimentions.soLargeDimention),
              child: DefaultButton(
                buttonColor: ColorResources.orange,
                onPressed: () async {
                  if (signUpFormKey.currentState!.validate()) {
                    if (await authProvider.createUser(
                        emailController.text, passwordController.text)) {
                      print('User created');
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const NavBar()),
                          (route) => false);
                    } else {
                      Mathods.showToast(
                          toastMessage: authProvider.firebaseErrorMessgase,
                          backGroundColor: ColorResources.grey);
                    }
                  }
                },
                child: const Text(
                  'SignUp',
                  style: TextStyle(
                      color: ColorResources.white,
                      fontFamily: Strings.notosansFontFamilly,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                          color: ColorResources.black.withOpacity(0.7))),
                  TextSpan(
                    text: 'LogIn',
                    style: const TextStyle(
                        fontFamily: Strings.notosansFontFamilly,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.blueAccent),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LogInScreen()));
                      },
                  ),
                ]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class PasswordStrenthContainer extends StatelessWidget {
  final double passwordPersent;
  const PasswordStrenthContainer({Key? key, this.passwordPersent = 0.0})
      : super(key: key);
  PasswordStrenthModel getMessag({double value = 0.0}) {
    if (value <= 0.3) {
      return const PasswordStrenthModel(
          color: ColorResources.red, message: Strings.weakPassword);
    } else if (value <= 0.6 && value > 0.3) {
      return const PasswordStrenthModel(
          color: ColorResources.orange, message: Strings.mediumPassword);
    } else if (value > 0.6) {
      return const PasswordStrenthModel(
          color: ColorResources.green, message: Strings.strongPassword);
    } else {
      return const PasswordStrenthModel(
          color: ColorResources.red, message: Strings.weakPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return passwordPersent == 0.0
        ? const SizedBox.shrink()
        : Container(
            margin:
                const EdgeInsets.symmetric(vertical: Dimentions.smallDimention),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border:
                    Border.all(color: getMessag(value: passwordPersent).color)),
            child: Text(
              getMessag(value: passwordPersent).message,
              style: TextStyle(
                  color: getMessag(value: passwordPersent).color,
                  fontFamily: Strings.notosansFontFamilly,
                  fontWeight: FontWeight.bold),
            ),
          );
  }
}

class PasswordStrenthModel {
  final Color color;
  final String message;
  const PasswordStrenthModel({required this.color, required this.message});
}

class ConfirmPasswordField extends StatefulWidget {
  final TextEditingController controller;

  final FormFieldValidator<String>? validator;

  const ConfirmPasswordField({
    Key? key,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  State<ConfirmPasswordField> createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<ConfirmPasswordField> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: !isVisible,
      style: const TextStyle(
          color: ColorResources.blueGrey,
          fontFamily: Strings.notosansFontFamilly),
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            child: Icon(isVisible ? Icons.visibility : Icons.visibility_off)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorResources.blueGrey)),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorResources.blueGrey)),
        hintText: 'Re-type your password',
        hintStyle: TextStyle(color: ColorResources.grey.withOpacity(0.9)),
      ),
    );
  }
}
