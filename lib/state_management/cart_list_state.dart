import 'package:flutter/widgets.dart';
import 'package:food_delivery/di_containers.dart';
import 'package:food_delivery/models/shopping_card_item_model.dart';
import 'package:food_delivery/utils/methods.dart';
import 'package:food_delivery/utils/repos/firestore_repo.dart';

class CartListState extends ChangeNotifier {
  bool isLoadingLocal = false;
  int get cartListLegnth => shoppingCartList.length;

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

  Future<List<ShoppingCardModel>> getCartListProducts(String userId) async {
    List<ShoppingCardModel> list = [];
    list = await Methods.decodeCartListDquerySnap(
        services<FirestoreRepos>().getShoppingCartList(userId));
    shoppingCartList = list;
    notifyListeners();
    return list;
  }

  changeProductQuantity(ShoppingCardModel shoppingCardModel, int newQuintity) {
    shoppingCartList[shoppingCartList.indexOf(shoppingCardModel)].quantity =
        newQuintity;
    notifyListeners();
  }
}
