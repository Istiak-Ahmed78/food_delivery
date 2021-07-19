import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/state_management/cart_list_state.dart';
import 'package:food_delivery/views/shared_widgets/appbar.dart';
import 'package:food_delivery/views/shared_widgets/drawer.dart';
import 'package:food_delivery/views/shared_widgets/expension.dart';
import 'package:food_delivery/views/shared_widgets/product_list_item.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:provider/provider.dart';

class FoodTab extends StatelessWidget {
  const FoodTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.white,
      drawerScrimColor: ColorResources.blueGrey,
      drawer: const DefaultDrawer(),
      appBar: defaultAppBar(
          title: 'My Orders',
          context: context,
          cartItemNumber: Provider.of<CartList>(context).cartList.length),
      body: SingleChildScrollView(
        child: Column(
          children: const [ExpensionList()],
        ),
      ),
    );
  }
}
