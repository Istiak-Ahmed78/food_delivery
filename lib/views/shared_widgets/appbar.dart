import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/views/styles/colors.dart';
import '../../constants.dart';

PreferredSizeWidget defaultAppBar(
        {required String title, int cartItemNumber = 0}) =>
    AppBar(
      title: Text(
        title,
        style: const TextStyle(
            color: kOrange, fontWeight: FontWeight.bold, fontFamily: kNotosans),
      ),
      actions: [
        Stack(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.shoppingCart,
                )),
            const Positioned(
              right: 2,
              top: 25,
              child: CircleAvatar(
                radius: 8,
                backgroundColor: kRed,
                child: Text(
                  '0',
                  style: TextStyle(color: kWhite, fontSize: 10),
                ),
              ),
            )
          ],
        ),
      ],
      iconTheme: const IconThemeData(
        color: kBlueAccent,
      ),
      backgroundColor: kWhite,
      elevation: 0.0,
      centerTitle: true,
    );
