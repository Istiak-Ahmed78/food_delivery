import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/views/styles/colors.dart';

class FavoriteTitle extends StatelessWidget {
  const FavoriteTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Expanded(
              child: Icon(
            Icons.favorite,
            color: ColorResources.blueGrey,
          )),
          Expanded(
            child: Text(
              'Favorite Foods',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: ColorResources.blueGrey,
              ),
            ),
            flex: 3,
          ),
          Expanded(
              child: Icon(
            Icons.menu,
            color: ColorResources.orange,
          )),
          Expanded(child: Icon(Icons.read_more))
        ],
      ),
    );
  }
}
