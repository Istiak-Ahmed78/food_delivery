import 'package:flutter/widgets.dart';
import 'package:food_delivery/models/shopping_card_item_model.dart';

class CartList extends ChangeNotifier {
  List<ShoppingCardModel> shoppingCartList = [];
  List<ShoppingCardModel> get cartList => shoppingCartList;
  addCartItem(ShoppingCardModel shoppingCardModel) {
    shoppingCartList.add(shoppingCardModel);
    notifyListeners();
  }

  changeProductQuantity(ShoppingCardModel shoppingCardModel, int newQuintity) {
    shoppingCartList[shoppingCartList.indexOf(shoppingCardModel)].quantity =
        newQuintity;
    notifyListeners();
  }
}
