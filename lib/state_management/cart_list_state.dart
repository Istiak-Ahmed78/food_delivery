import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/di_containers.dart';
import 'package:food_delivery/models/shopping_card_item_model.dart';
import 'package:food_delivery/utils/repos/firestore_repo.dart';

class CartListState extends ChangeNotifier {
  bool isLoadingLocal = false;
  int cartListLegnthLoacal = 0;

  int get cartListLegnth => cartListLegnthLoacal;

  List<ShoppingCardModel> shoppingCartList = [];
  List<ShoppingCardModel> checkOutList = [];

  List<ShoppingCardModel> get cartList => shoppingCartList;
  List<ShoppingCardModel> get globalCheckedOutList => checkOutList;

  addCartItem(
      ShoppingCardModel shoppingCardModel, String userId, String productId) {
    isLoadingLocal = true;
    notifyListeners();
    shoppingCartList.add(shoppingCardModel);
    services<FirestoreRepos>()
        .addFoodItemToShoppingList(shoppingCardModel, userId, productId);
    isLoadingLocal = false;
    notifyListeners();
  }

  Future<bool> aleadyInTheList(String userId, String productIdToTest) {
    return services<FirestoreRepos>()
        .isAlreadyInTheList(userId, productIdToTest);
  }

  void chechedOut() {
    checkOutList.addAll(shoppingCartList);
    shoppingCartList.clear();
    notifyListeners();
  }

  Future<void> cartListLength(String userId) async {
    int listLenth = await (getCartListProducts(userId))
        .then((value) => value.docs.length)
        .onError((error, stackTrace) => 0);
    cartListLegnthLoacal = listLenth;
    notifyListeners();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCartListProducts(
          String userId) =>
      services<FirestoreRepos>().getShoppingCartList(userId);

  changeProductQuantity(ShoppingCardModel shoppingCardModel, int newQuintity) {
    shoppingCartList[shoppingCartList.indexOf(shoppingCardModel)].quantity =
        newQuintity;
    notifyListeners();
  }
}
