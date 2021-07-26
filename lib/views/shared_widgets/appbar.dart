import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/di_containers.dart';
import 'package:food_delivery/state_management/cart_list_state.dart';
import 'package:food_delivery/utils/repos/auth_repo.dart';
import 'package:food_delivery/views/screens/shopping_cart_list/shopping_cart_list.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:food_delivery/views/styles/paddings.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

PreferredSizeWidget defaultAppBar(
        {required String title,
        int cartItemNumber = 0,
        required BuildContext context}) =>
    AppBar(
      title: Text(
        title,
        style: const TextStyle(
            color: ColorResources.orange,
            fontWeight: FontWeight.bold,
            fontFamily: Strings.notosansFontFamilly),
      ),
      actions: const [AppBarAction()],
      iconTheme: const IconThemeData(
        color: ColorResources.blueAccent,
      ),
      backgroundColor: ColorResources.white,
      elevation: 0.0,
      centerTitle: true,
    );

class AppBarAction extends StatelessWidget {
  const AppBarAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartListProvider = Provider.of<CartListState>(context, listen: false)
        .getCartListProducts(services<AuthRepos>().getCurrentUser()!.uid);

    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Stack(
        children: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartScreen()));
              },
              icon: const Icon(
                FontAwesomeIcons.shoppingCart,
              )),
          Positioned(
            right: 2,
            top: 25,
            child: CircleAvatar(
                radius: 8,
                backgroundColor: ColorResources.orange,
                child: Consumer<CartListState>(
                  builder: (context, data, _) {
                    return Text(
                      data.cartList.length.toString(),
                      style: const TextStyle(
                          color: ColorResources.white,
                          fontSize: Dimentions.soSmallDinmention),
                    );
                  },
                )),
          )
        ],
      ),
    );
  }
}
