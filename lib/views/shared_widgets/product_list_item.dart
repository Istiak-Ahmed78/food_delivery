import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/models/order_model.dart';
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kPadding10),
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
                        color: kBlueGrey.withOpacity(0.7)),
                  ),
                  const SizedBox(
                    height: kPadding10,
                  ),
                  Text(
                    orderModel.restaurentListItemModel.subTitle,
                    style: const TextStyle(color: kGrey),
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
                  padding: const EdgeInsets.symmetric(horizontal: kPadding10),
                  child: Text('\$${orderModel.restaurentListItemModel.price}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: kBlueGrey)),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: kPadding10),
                      child: Text(
                          '\$${orderModel.restaurentListItemModel.price}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: kNotosans,
                              color: kBlueGrey,
                              fontSize: 20)),
                    ),
                    Text(
                      '${DateFormat.yMd().format(orderModel.orderTime!).toString()}',
                      style:
                          const TextStyle(color: kGrey, fontFamily: kNotosans),
                    ),
                    Text(
                      '${DateFormat.jm().format(orderModel.orderTime!).toString()}',
                      style:
                          const TextStyle(color: kGrey, fontFamily: kNotosans),
                    )
                  ],
                ),
        ],
      ),
    );
  }
}
