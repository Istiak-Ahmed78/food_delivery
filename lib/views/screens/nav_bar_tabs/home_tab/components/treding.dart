import 'package:flutter/material.dart';
import 'package:food_delivery/models/trending_food_model.dart';
import 'package:food_delivery/views/shared_widgets/headline.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:food_delivery/views/styles/paddings.dart';

class TreddingFoods extends StatelessWidget {
  const TreddingFoods({Key? key}) : super(key: key);

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
                  scrollDirection: Axis.horizontal,
                  itemCount: TrendingFoodModel.trendinFoodList.length,
                  itemBuilder: (context, index) => TrendingFoods(
                        trendingFoods: TrendingFoodModel.trendinFoodList[index],
                      )))
        ],
      ),
    );
  }
}

class TrendingFoods extends StatelessWidget {
  final TrendingFoodModel trendingFoods;
  const TrendingFoods({Key? key, required this.trendingFoods})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(right: kPadding20),
      child: Card(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                        style: TextStyle(color: kGrey),
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
                    color: kOrange,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    '\$${trendingFoods.price.toString()}',
                    style: const TextStyle(color: kWhite),
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
