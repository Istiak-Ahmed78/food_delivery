import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/views/screens/shopping_cart_list/shopping_cart_list.dart';
import 'package:food_delivery/views/styles/colors.dart';
import '../../constants.dart';

PreferredSizeWidget defaultAppBar(
        {required String title,
        int cartItemNumber = 0,
        required BuildContext context}) =>
    AppBar(
      title: Text(
        title,
        style: const TextStyle(
            color: ColorResources.orange,
            fontWeight: FontWeight.bold,
            fontFamily: Strings.notosansFontFamilly),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Stack(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartScreen()));
                  },
                  icon: const Icon(
                    FontAwesomeIcons.shoppingCart,
                  )),
              const Positioned(
                right: 2,
                top: 25,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: ColorResources.orange,
                  child: Text(
                    '0',
                    style: TextStyle(color: ColorResources.white, fontSize: 10),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
      iconTheme: const IconThemeData(
        color: ColorResources.blueAccent,
      ),
      backgroundColor: ColorResources.white,
      elevation: 0.0,
      centerTitle: true,
    );
