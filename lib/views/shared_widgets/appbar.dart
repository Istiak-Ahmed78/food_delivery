import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/di_containers.dart';
import 'package:food_delivery/state_management/cart_list_state.dart';
import 'package:food_delivery/utils/repos/auth_repo.dart';
import 'package:food_delivery/views/screens/shopping_cart_list/shopping_cart_list.dart';
import 'package:food_delivery/views/styles/colors.dart';
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

class AppBarAction extends StatefulWidget {
  const AppBarAction({Key? key}) : super(key: key);

  @override
  State<AppBarAction> createState() => _AppBarActionState();
}

class _AppBarActionState extends State<AppBarAction> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPersistentFrameCallback((timeStamp) {});
  }

  void inits() async {
    Provider.of<CartListState>(context)
        .cartListLength(services<AuthRepos>().getCurrentUser()!.uid);
  }

  @override
  Widget build(BuildContext context) {
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
              child: Text(
                Provider.of<CartListState>(context).cartListLegnth.toString(),
                style:
                    const TextStyle(color: ColorResources.white, fontSize: 10),
              ),
            ),
          )
        ],
      ),
    );
  }
}
