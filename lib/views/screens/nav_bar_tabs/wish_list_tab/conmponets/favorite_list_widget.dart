import 'package:flutter/material.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/models/restaurant_model.dart';
import 'package:food_delivery/views/shared_widgets/shared_widgets.dart';

class FavoriteListWidget extends StatelessWidget {
  FavoriteListWidget({Key? key}) : super(key: key);
  final List<OrderModel> favoriteList = List.generate(
      2,
      (index) => OrderModel(
          restaurentListItemModel:
              RestaurentListItemModel.topRestaurentList[index]));
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        itemBuilder: (context, index) =>
            FoodItemTile(orderModel: favoriteList[index]),
        itemCount: favoriteList.length,
        shrinkWrap: true,
      ),
    );
  }
}
