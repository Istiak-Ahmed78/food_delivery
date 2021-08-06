import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/di_containers.dart';
import 'package:food_delivery/models/food_model.dart';
import 'package:food_delivery/utils/methods.dart';
import 'package:food_delivery/utils/repos/firestore_repo.dart';
import 'package:food_delivery/views/screens/product_deatils_screen/product_details_screen.dart';
import 'package:food_delivery/views/shared_widgets/headline.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:food_delivery/views/styles/paddings.dart';

class FoodSectionWidget extends StatefulWidget {
  final String collectionId, title, subtitle;

  const FoodSectionWidget(
      {Key? key,
      required this.collectionId,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  State<FoodSectionWidget> createState() => _FoodSectionWidgetState();
}

class _FoodSectionWidgetState extends State<FoodSectionWidget> {
  List<FoodModel> foodModelList = [];
  @override
  void initState() {
    super.initState();
    getInitData();
  }

  void getInitData() async {
    final qDocSnapShot =
        await services<FirestoreRepos>().getProduts(widget.collectionId);
    foodModelList = Methods.getFoodListFromDQuerySnap(qDocSnapShot.docs);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.only(bottom: Dimentions.smallDimention),
        width: _size.width,
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HeadLine(
              title: widget.title,
              subTitle: widget.subtitle,
              iconData: Icons.stars,
            ),
            SizedBox(
              height: _size.height * 0.02,
            ),
            foodModelList.isEmpty
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                            right: Dimentions.soSmallDinmention),
                        scrollDirection: Axis.horizontal,
                        itemCount: foodModelList.length,
                        itemBuilder: (context, index) => TrendingFoods(
                              trendingFoods: foodModelList[index],
                            ))),
          ],
        ));
  }
}

class TrendingFoods extends StatelessWidget {
  final FoodModel trendingFoods;
  const TrendingFoods({Key? key, required this.trendingFoods})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(
                            trendingFoodModel: trendingFoods,
                          )));
            },
            child: Stack(
              children: [
                SizedBox(
                  width: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(trendingFoods.imageUrl),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: Text(
                          trendingFoods.title,
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                          style: const TextStyle(color: CResources.grey),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 14,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: CResources.orange,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      '\$${trendingFoods.price.toString()}',
                      style: const TextStyle(color: CResources.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
