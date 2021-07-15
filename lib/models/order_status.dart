import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class OrderStatusModel {
  final String title, subTitle;
  final bool isDone;
  final IconData icon;
  const OrderStatusModel(
      {required this.title,
      required this.icon,
      required this.isDone,
      required this.subTitle});

  static List<OrderStatusModel> getOrderSatatusList(
      DelivertyStatus orderStatus) {
    if (orderStatus == DelivertyStatus.orderPlaced) {
      return const [
        OrderStatusModel(
            title: 'Order Placed',
            icon: Icons.work,
            isDone: true,
            subTitle: 'We have successfully received your order request.'),
        OrderStatusModel(
            title: 'In the kitchen',
            icon: Icons.outdoor_grill,
            isDone: false,
            subTitle:
                'Our shafe is making your your food.Soon it will be prepered'),
        OrderStatusModel(
            title: 'On the way',
            icon: Icons.local_shipping,
            isDone: false,
            subTitle:
                'Hold on. Our delevery boy is no the way. Soon he will reach you.'),
        OrderStatusModel(
            title: 'Delivered',
            icon: FontAwesomeIcons.handHolding,
            isDone: false,
            subTitle: 'We have successfully delevered your product to you.')
      ];
    } else if (orderStatus == DelivertyStatus.inTheKitchen) {
      return const [
        OrderStatusModel(
            title: 'Order Placed',
            icon: Icons.work,
            isDone: true,
            subTitle: 'We have successfully received your order request.'),
        OrderStatusModel(
            title: 'In the kitchen',
            icon: Icons.outdoor_grill,
            isDone: true,
            subTitle:
                'Our shafe is making your your food.Soon it will be prepered'),
        OrderStatusModel(
            title: 'On the way',
            icon: Icons.local_shipping,
            isDone: false,
            subTitle:
                'Hold on. Our delevery boy is no the way. Soon he will reach you.'),
        OrderStatusModel(
            title: 'Delivered',
            subTitle: 'We have successfully delevered your product to you.',
            icon: FontAwesomeIcons.handHolding,
            isDone: false)
      ];
    } else if (orderStatus == DelivertyStatus.onTheWay) {
      return const [
        OrderStatusModel(
            title: 'Order Placed',
            icon: Icons.work,
            isDone: true,
            subTitle: 'We have successfully received your order request.'),
        OrderStatusModel(
            title: 'In the kitchen',
            icon: Icons.outdoor_grill,
            isDone: true,
            subTitle:
                'Our shafe is making your your food.Soon it will be prepered'),
        OrderStatusModel(
            title: 'On the way',
            icon: Icons.local_shipping,
            isDone: true,
            subTitle:
                'Hold on. Our delevery boy is no the way. Soon he will reach you.'),
        OrderStatusModel(
            title: 'Delivered',
            icon: FontAwesomeIcons.handHolding,
            subTitle: 'We have successfully delevered your product to you.',
            isDone: false)
      ];
    } else {
      return const [
        OrderStatusModel(
            title: 'Order Placed',
            icon: Icons.work,
            isDone: true,
            subTitle: 'We have successfully received your order request.'),
        OrderStatusModel(
            title: 'In the kitchen',
            icon: Icons.outdoor_grill,
            isDone: true,
            subTitle:
                'Our shafe is making your your food.Soon it will be prepered'),
        OrderStatusModel(
            title: 'On the way',
            icon: Icons.local_shipping,
            isDone: true,
            subTitle:
                'Hold on. Our delevery boy is no the way. Soon he will reach you.'),
        OrderStatusModel(
            title: 'Delivered',
            icon: FontAwesomeIcons.handHolding,
            subTitle: 'We have successfully delevered your product to you.',
            isDone: true)
      ];
    }
  }
}
