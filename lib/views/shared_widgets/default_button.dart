import 'package:flutter/material.dart';
import 'package:food_delivery/views/styles/colors.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color buttonColor;
  final Widget child;
  const DefaultButton(
      {Key? key,
      required this.onPressed,
      required this.child,
      this.buttonColor = ColorResources.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 50,
      minWidth: double.infinity,
      color: buttonColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: child,
    );
  }
}
