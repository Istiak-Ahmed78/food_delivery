import 'package:flutter/widgets.dart';
import 'package:food_delivery/models/order_model.dart';

class RecentOrderState extends ChangeNotifier {
  List<OrderModel> recentOrderList = [];
  List<OrderModel> get cartList => recentOrderList;
  addCartItem(OrderModel orderModel) {
    recentOrderList.add(orderModel);
    notifyListeners();
  }
}
