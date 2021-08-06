import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/models/food_model.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/views/screens/product_deatils_screen/product_details_screen.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:food_delivery/views/styles/paddings.dart';
import 'package:intl/intl.dart';

class FoodItemTile extends StatelessWidget {
  final OrderModel orderModel;
  const FoodItemTile({Key? key, required this.orderModel}) : super(key: key);
  String dateConvert(String time) => DateFormat.yMd().parse(time).toString();
  String convertToTime(String time) => DateFormat.jm().parse(time).toString();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(
                      trendingFoodModel: FoodModel(
                          weight: '300 g',
                          productId: 's',
                          imageUrl:
                              orderModel.restaurentListItemModel.imageAdress,
                          title: orderModel.restaurentListItemModel.title,
                          price: orderModel.restaurentListItemModel.price),
                    )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: Dimentions.soSmallDinmention),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                    image: NetworkImage(
                        orderModel.restaurentListItemModel.imageAdress),
                    fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      orderModel.restaurentListItemModel.title,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CResources.blueGrey.withOpacity(0.7)),
                    ),
                    const SizedBox(
                      height: Dimentions.smallDimention,
                    ),
                    Text(
                      orderModel.restaurentListItemModel.subTitle,
                      style: const TextStyle(color: CResources.grey),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    )
                  ],
                ),
              ),
            ),
            orderModel.orderTime == null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimentions.soSmallDinmention),
                    child: Text('\$${orderModel.restaurentListItemModel.price}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CResources.blueGrey)),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimentions.soSmallDinmention),
                        child: Text(
                            '\$${orderModel.restaurentListItemModel.price}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: Strings.notosansFontFamilly,
                                color: CResources.blueGrey,
                                fontSize: 20)),
                      ),
                      Text(
                        '${DateFormat.yMd().format(orderModel.orderTime!)}',
                        style: const TextStyle(
                            color: CResources.grey,
                            fontFamily: Strings.notosansFontFamilly),
                      ),
                      Text(
                        '${DateFormat.jm().format(orderModel.orderTime!).toString()}',
                        style: const TextStyle(
                            color: CResources.grey,
                            fontFamily: Strings.notosansFontFamilly),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
