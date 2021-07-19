import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:password_strength/password_strength.dart';

class Mathods {
  static void showToast(
      {required String toastMessage,
      Color backGroundColor = ColorResources.orange}) {
    Fluttertoast.showToast(
        msg: toastMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backGroundColor,
        textColor: ColorResources.white,
        fontSize: 16.0);
  }

  static double getStrenthOfPassword(String password) =>
      estimatePasswordStrength(password);
}
