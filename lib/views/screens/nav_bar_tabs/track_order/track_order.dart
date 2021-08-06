import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/di_containers.dart';
import 'package:food_delivery/models/shopping_card_item_model.dart';
import 'package:food_delivery/state_management/cart_list_state.dart';
import 'package:food_delivery/utils/repos/firestore_repo.dart';
import 'package:food_delivery/views/screens/tracking_details/tracking_details_screen.dart';
import 'package:food_delivery/views/shared_widgets/drawer.dart';
import 'package:food_delivery/views/shared_widgets/shared_widgets.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:provider/provider.dart';

class TracOrders extends StatelessWidget {
  const TracOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ShoppingCardModel> orderList =
        Provider.of<CartListState>(context).globalCheckedOutList;
    return Scaffold(
      drawer: const DefaultDrawer(),
      appBar: defaultAppBar(context: context, title: 'Track your order'),
      body: SafeArea(
        child: SingleChildScrollView(
            child: FutureBuilder(
          future: services<FirestoreRepos>().getOrderedList(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return const LoadingShimmerWidget();
            } else {
              if (snapshot.data?.docs != null &&
                  snapshot.data!.docs.isNotEmpty) {
                return ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ShowcaseTimelineTile()));
                    },
                    title: Text(
                      orderList[index].foodModel.title,
                      style: const TextStyle(
                          color: ColorResources.blueGrey,
                          fontFamily: Strings.notosansFontFamilly),
                    ),
                    subtitle: const Text('State: Proccessing'),
                    leading: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          image: DecorationImage(
                              image: NetworkImage(
                                  orderList[index].foodModel.imageUrl))),
                    ),
                  ),
                  shrinkWrap: true,
                  itemCount: orderList.length,
                );
              } else {
                return const Center(
                  child: Text('Sorry no availble'),
                );
              }
            }
          },
        )),
      ),
    );
  }
}
