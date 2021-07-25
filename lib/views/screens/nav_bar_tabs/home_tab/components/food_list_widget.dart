import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/di_containers.dart';
import 'package:food_delivery/models/food_heading_model.dart';
import 'package:food_delivery/utils/methods.dart';
import 'package:food_delivery/utils/repos/firestore_repo.dart';
import 'package:food_delivery/views/screens/nav_bar_tabs/home_tab/components/components.dart';

class FoodListWidget extends StatelessWidget {
  const FoodListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FutureBuilder(
        future: services<FirestoreRepos>().getProductSectionHeadings(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            if (snapshot.data!.docs.isNotEmpty) {
              List<FoodHeadingModel> foodHeadingList =
                  Methods.decodeFoodHeadignDQsnapshot(snapshot.data!.docs);
              return ListView.builder(
                itemBuilder: (context, index) => FoodSectionWidget(
                  collectionId: foodHeadingList[index].id,
                  title: foodHeadingList[index].title,
                  subtitle: foodHeadingList[index].subtitle,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: foodHeadingList.length,
              );
              // return const Text('We have some data');
            } else {
              return const Text('The list is emty');
            }
          } else {
            return const Text('Something went wrong');
          }
        },
      ),
    );
  }
}
