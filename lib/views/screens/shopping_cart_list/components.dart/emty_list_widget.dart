import 'package:flutter/material.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:food_delivery/views/styles/paddings.dart';
import '../../../../constants.dart';

class EmtyListWidget extends StatelessWidget {
  const EmtyListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(
                  top: _size.height * 0.2, bottom: Dimentions.largeDimention),
              // height: _size.height * 0.6,
              width: _size.width * 0.6,
              child: Image.asset(
                Images.noItem,
              )),
          const Text(
            'No item to show',
            style: TextStyle(
                fontFamily: Strings.notosansFontFamilly,
                fontSize: Dimentions.mediamDimention,
                color: CResources.blueGrey,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
