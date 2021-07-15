import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/views/styles/colors.dart';

class Headline extends StatelessWidget {
  const Headline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Icon(
              FontAwesomeIcons.addressCard,
              color: kBlueGrey,
            ),
          ),
          SizedBox(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Payment Mode',
                    style: TextStyle(
                        color: kBlueGrey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: kNotosans),
                  ),
                  Text('Select your prefered payment mode',
                      style: TextStyle(fontFamily: kNotosans, color: kGrey)),
                ]),
          )
        ],
      ),
    );
  }
}
