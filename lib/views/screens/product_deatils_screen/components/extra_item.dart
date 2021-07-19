import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/models/food_model.dart';
import 'package:food_delivery/views/styles/colors.dart';

class ExtraItem extends StatelessWidget {
  final FoodModel foodModel;
  const ExtraItem({Key? key, required this.foodModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(foodModel.imageUrl), fit: BoxFit.cover)),
      ),
      title: Text(
        foodModel.title,
        style: const TextStyle(
            color: ColorResources.blueGrey,
            fontFamily: Strings.notosansFontFamilly),
      ),
      subtitle: Text(
        'Add some ${foodModel.title}',
        style: const TextStyle(fontFamily: Strings.notosansFontFamilly),
      ),
      trailing: Text(
        '\$${foodModel.price}',
        style: const TextStyle(
            fontFamily: Strings.notosansFontFamilly,
            color: ColorResources.blueGrey,
            fontSize: 18),
      ),
    );
  }
}
