import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/views/shared_widgets/appbar.dart';
import 'package:food_delivery/views/shared_widgets/product_list_item.dart';
import 'package:food_delivery/views/styles/colors.dart';

class FoodTab extends StatelessWidget {
  const FoodTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kWhite,
        title: defaultAppBar(title: 'My Orders'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionTile(
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
            )
          ],
        ),
      ),
    );
  }
}
