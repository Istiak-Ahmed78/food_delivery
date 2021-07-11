import 'package:flutter/material.dart';
import 'package:food_delivery/state_management/cart_list_state.dart';
import 'package:food_delivery/views/shared_widgets/appbar.dart';
import 'package:food_delivery/views/shared_widgets/drawer.dart';
import 'package:food_delivery/views/shared_widgets/search_widget.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:food_delivery/views/styles/paddings.dart';
import 'package:provider/provider.dart';
import 'components/components.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        drawer: const DefaultDrawer(),
        drawerScrimColor: kBlack,
        appBar: defaultAppBar(
          title: 'Home',
          context: context,
          cartItemNumber: Provider.of<CartList>(context).cartList.length,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, bottom: kToolbarHeight),
            child: Column(children: const [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SearchRestaurant()),
              SizedBox(
                height: kPadding10,
              ),
              TopRestaurentsWiget(),
              SizedBox(
                height: kPadding15,
              ),
              TreddingFoodListWidget()
            ]),
          ),
        ));
  }
}
