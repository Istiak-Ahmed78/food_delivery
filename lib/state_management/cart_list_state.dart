import 'package:flutter/widgets.dart';
import 'package:food_delivery/models/shopping_card_item_model.dart';

class CartList extends ChangeNotifier {
  List<ShoppingCardModel> shoppingCartList = [];
  List<ShoppingCardModel> checkOutList = [];

  List<ShoppingCardModel> get cartList => shoppingCartList;
  List<ShoppingCardModel> get globalCheckedOutList => checkOutList;

  addCartItem(ShoppingCardModel shoppingCardModel) {
    shoppingCartList.add(shoppingCardModel);
    notifyListeners();
  }

  void chechedOut() {
    checkOutList.addAll(shoppingCartList);
    shoppingCartList.clear();
    notifyListeners();
  }

  changeProductQuantity(ShoppingCardModel shoppingCardModel, int newQuintity) {
    shoppingCartList[shoppingCartList.indexOf(shoppingCardModel)].quantity =
        newQuintity;
    notifyListeners();
  }
}
