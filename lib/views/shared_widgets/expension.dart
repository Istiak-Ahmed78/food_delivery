import 'package:flutter/material.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/views/styles/colors.dart';
import '../../constants.dart';
import 'product_list_item.dart';

class ExpensionList extends StatelessWidget {
  const ExpensionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Text(
        'Expention List',
        style: TextStyle(
            color: kOrange,
            fontFamily: kNotosans,
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
      title: const Text(
        'Order Received',
        style: TextStyle(color: kGrey),
      ),
      children: [
        for (final singleItem in OrderModel.orderModelList)
          FoodItemTile(orderModel: singleItem)
      ],
    );
  }
}
