import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery/models/food_heading_model.dart';
import 'package:food_delivery/models/food_model.dart';
import 'package:food_delivery/models/shopping_card_item_model.dart';
import 'package:food_delivery/state_management/auth_providers.dart';
import 'package:food_delivery/views/shared_widgets/loading_idicator.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:password_strength/password_strength.dart';
import 'package:provider/provider.dart';

class Methods {
  static void showToast(
      {required String toastMessage,
      Color backGroundColor = CResources.orange,
      Toast duration = Toast.LENGTH_SHORT}) {
    Fluttertoast.showToast(
        msg: toastMessage,
        toastLength: duration,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backGroundColor,
        textColor: CResources.white,
        fontSize: 16.0);
  }

  static double getStrenthOfPassword(String password) =>
      estimatePasswordStrength(password);

  static void emtyEmailWarning(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: const Text(
                  "To procceed, enter your valid email adress in the email field."),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok')),
              ]);
        });
  }

  static void showVerificationAskingDialog(context, user) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Your email adress need verification"),
              content: const Text(
                  "Your email is not verified.You cannot logIn without verifing your email adress."),
              actions: [
                TextButton(
                    onPressed: () async {
                      await Provider.of<AuthProvider>(context, listen: false)
                          .sendVerificationEmail(user);
                      Navigator.pop(context);
                    },
                    child: const Text('Send verification email again')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok')),
              ]);
        });
  }

  static Future<void> showLoadingIndicator(
      {required BuildContext context,
      String? text,
      Future<void>? workTodo}) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          backgroundColor: Colors.black87,
          content: LoadingIndicator(text: text),
        );
      },
    );
    if (workTodo != null) {
      await Future.delayed(Duration.zero, () {
        workTodo.then((_) {
          Navigator.pop(context);
        });
      });
    }
  }

  static List<FoodHeadingModel> decodeFoodHeadignDQsnapshot(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> querySnapshot) {
    List<FoodHeadingModel> foodHeadigList = [];
    for (final item in querySnapshot) {
      foodHeadigList.add(FoodHeadingModel.fromMap(item.data()));
    }
    return foodHeadigList;
  }

  static List<ShoppingCardModel> decodeToShoppingList(
      QuerySnapshot<Map<String, dynamic>>? querySnapshot) {
    List<ShoppingCardModel> shoppingCartList = [];
    if (querySnapshot != null) {
      for (final item in (querySnapshot).docs) {
        shoppingCartList.add(ShoppingCardModel.fromMap(item.data()));
      }
    }
    return shoppingCartList;
  }

  static List<FoodModel> getFoodListFromDQuerySnap(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> queryDocumentSnapshot) {
    List<FoodModel> foodList = [];
    for (final item in queryDocumentSnapshot) {
      foodList.add(FoodModel.fromMap(item.data(), item.id));
    }
    return foodList;
  }
}
