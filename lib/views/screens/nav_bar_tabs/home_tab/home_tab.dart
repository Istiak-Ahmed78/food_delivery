import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:food_delivery/views/styles/paddings.dart';
import 'components/components.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        drawer: const HomeTabDrawer(),
        drawerScrimColor: kBlack,
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(
                color: kOrange,
                fontWeight: FontWeight.bold,
                fontFamily: kNotosans),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.shoppingCart,
                )),
          ],
          iconTheme: const IconThemeData(
            color: kBlueAccent,
          ),
          backgroundColor: kWhite,
          elevation: 0.0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, bottom: kToolbarHeight),
            child: Column(children: const [
              SearchRestaurant(),
              SizedBox(
                height: kPadding10,
              ),
              TopRestaurentsWiget(),
              SizedBox(
                height: kPadding15,
              ),
              TreddingFoods()
            ]),
          ),
        ));
  }
}
