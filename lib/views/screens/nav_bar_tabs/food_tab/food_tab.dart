import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/views/shared_widgets/appbar.dart';
import 'package:food_delivery/views/shared_widgets/expension.dart';
import 'package:food_delivery/views/shared_widgets/product_list_item.dart';
import 'package:food_delivery/views/styles/colors.dart';

class FoodTab extends StatelessWidget {
  const FoodTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      drawerScrimColor: kBlueGrey,
      drawer: const Drawer(),
      appBar: defaultAppBar(title: 'My Orders'),
      body: SingleChildScrollView(
        child: Column(
          children: const [ExpensionList()],
        ),
      ),
    );
  }
}
