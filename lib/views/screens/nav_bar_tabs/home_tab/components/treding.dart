import 'package:flutter/material.dart';
import 'package:food_delivery/models/food_model.dart';
import 'package:food_delivery/views/screens/product_deatils_screen/product_details_screen.dart';
import 'package:food_delivery/views/shared_widgets/headline.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:food_delivery/views/styles/paddings.dart';

class TreddingFoodListWidget extends StatelessWidget {
  const TreddingFoodListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: 270,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const HeadLine(
            title: 'Top Restaurents',
            subTitle: 'Ordered by Nearby first',
            iconData: Icons.stars,
          ),
          SizedBox(
            height: _size.height * 0.02,
          ),
          Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(
                      right: Dimentions.soSmallDinmention),
                  scrollDirection: Axis.horizontal,
                  itemCount: FoodModel.trendinFoodList.length,
                  itemBuilder: (context, index) => TrendingFoods(
                        trendingFoods: FoodModel.trendinFoodList[index],
                      )))
        ],
      ),
    );
  }
}

class TrendingFoods extends StatelessWidget {
  final FoodModel trendingFoods;
  const TrendingFoods({Key? key, required this.trendingFoods})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                        style: const TextStyle(color: ColorResources.grey),
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
                    color: ColorResources.orange,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    '\$${trendingFoods.price.toString()}',
                    style: const TextStyle(color: ColorResources.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
