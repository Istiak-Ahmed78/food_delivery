import 'package:flutter/widgets.dart';
import 'package:food_delivery/models/order_model.dart';

class FavoriteFoodItems extends ChangeNotifier {
  List<OrderModel> localFavList = [];
  List<OrderModel> get favList => localFavList;
  addFav(OrderModel orderModel) {
    localFavList.add(orderModel);
    notifyListeners();
  }
}
