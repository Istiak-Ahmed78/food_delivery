import 'package:flutter/material.dart';
import 'package:food_delivery/views/screens/nav_bar_tabs/wish_list_tab/conmponets/componets.dart';
import 'package:food_delivery/views/shared_widgets/shared_widgets.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:food_delivery/views/styles/paddings.dart';

class WishListTab extends StatelessWidget {
  const WishListTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(title: 'Favorites', cartItemNumber: 0),
      drawer: const DefaultDrawer(),
      drawerScrimColor: kBlack,
      body: Container(
        padding: const EdgeInsets.only(top: kPadding10, bottom: kToolbarHeight),
        child: Column(
          children: [
            const SearchRestaurant(),
            const SizedBox(
              height: kPadding15,
            ),
            const FavoriteTitle(),
            const SizedBox(
              height: kPadding15,
            ),
            FavoriteListWidget()
          ],
        ),
      ),
    );
  }
}
