import 'package:flutter/material.dart';
import 'package:food_delivery/state_management/favorite_list_state.dart';
import 'package:food_delivery/views/shared_widgets/shared_widgets.dart';
import 'package:provider/provider.dart';

class FavoriteListWidget extends StatelessWidget {
  const FavoriteListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // child: ListView.builder(
        //   itemBuilder: (context, index) => FoodItemTile(
        //       orderModel: Provider.of<FavoriteFoodItems>(context).favList[index]),
        //   itemCount: Provider.of<FavoriteFoodItems>(context).favList.length,
        //   shrinkWrap: true,
        // ),
        );
  }
}
