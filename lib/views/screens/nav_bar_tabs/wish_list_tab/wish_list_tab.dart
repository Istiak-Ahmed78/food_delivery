import 'package:flutter/material.dart';
import 'package:food_delivery/state_management/cart_list_state.dart';
import 'package:food_delivery/views/screens/nav_bar_tabs/wish_list_tab/conmponets/componets.dart';
import 'package:food_delivery/views/shared_widgets/shared_widgets.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:food_delivery/views/styles/paddings.dart';
import 'package:provider/provider.dart';

class WishListTab extends StatelessWidget {
  const WishListTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
          title: 'Favorites',
          context: context,
          cartItemNumber: Provider.of<CartListState>(context).cartList.length),
      drawer: const DefaultDrawer(),
      drawerScrimColor: CResources.black,
      body: Container(
        padding: const EdgeInsets.only(
            top: Dimentions.soSmallDinmention, bottom: kToolbarHeight),
        child: Column(
          children: const [
            SearchRestaurant(),
            SizedBox(
              height: Dimentions.smallDimention,
            ),
            FavoriteTitle(),
            SizedBox(
              height: Dimentions.smallDimention,
            ),
            FavoriteListWidget()
          ],
        ),
      ),
    );
  }
}
