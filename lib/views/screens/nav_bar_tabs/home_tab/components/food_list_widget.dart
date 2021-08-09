import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/di_containers.dart';
import 'package:food_delivery/models/food_heading_model.dart';
import 'package:food_delivery/utils/methods.dart';
import 'package:food_delivery/utils/repos/firestore_repo.dart';
import 'package:food_delivery/views/screens/nav_bar_tabs/home_tab/components/components.dart';

class FoodListWidget extends StatefulWidget {
  const FoodListWidget({Key? key}) : super(key: key);

  @override
  State<FoodListWidget> createState() => _FoodListWidgetState();
}

class _FoodListWidgetState extends State<FoodListWidget> {
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
              List<String> foodHeadingList =
                  Methods.decodeFoodHeadignDQsnapshot(snapshot.data!);
              print(foodHeadingList.length);
              return SizedBox(
                child: ListView.builder(
                  itemBuilder: (context, index) => FoodSectionWidget(
                    category: foodHeadingList[index],
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: foodHeadingList.length,
                ),
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
