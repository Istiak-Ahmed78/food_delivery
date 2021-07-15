import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/models/shopping_card_item_model.dart';
import 'package:food_delivery/state_management/cart_list_state.dart';
import 'package:food_delivery/views/screens/tracking_details/tracking_details.dart';
import 'package:food_delivery/views/shared_widgets/drawer.dart';
import 'package:food_delivery/views/shared_widgets/shared_widgets.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:provider/provider.dart';

class TracOrders extends StatelessWidget {
  const TracOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ShoppingCardModel> orderList =
        Provider.of<CartList>(context).checkOutList;
    return Scaffold(
      drawer: const DefaultDrawer(),
      appBar: defaultAppBar(context: context, title: 'Track your order'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ListView.builder(
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ShowcaseTimelineTile()));
              },
              title: Text(
                orderList[index].trendingFoodModel.title,
                style: const TextStyle(color: kBlueGrey, fontFamily: kNotosans),
              ),
              subtitle: const Text('State: Proccessing'),
              leading: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            orderList[index].trendingFoodModel.imageUrl))),
              ),
            ),
            shrinkWrap: true,
            itemCount: orderList.length,
          ),
        ),
      ),
    );
  }
}
