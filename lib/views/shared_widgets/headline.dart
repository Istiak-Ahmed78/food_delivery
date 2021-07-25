import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/views/styles/colors.dart';

class HeadLine extends StatelessWidget {
  final String title, subTitle;
  final IconData iconData;
  const HeadLine(
      {Key? key,
      required this.title,
      required this.iconData,
      required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Expanded(
        flex: 1,
        child: Icon(
          Icons.stars,
          color: ColorResources.blueGrey,
        ),
      ),
      Expanded(
        flex: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorResources.blueAccent,
                  fontFamily: Strings.notosansFontFamilly),
            ),
            Text(subTitle,
                style: const TextStyle(fontFamily: Strings.notosansFontFamilly))
          ],
        ),
      )
    ]);
  }
}
