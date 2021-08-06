import 'package:flutter/widgets.dart';
import 'package:food_delivery/di_containers.dart';
import 'package:food_delivery/models/shopping_card_item_model.dart';
import 'package:food_delivery/utils/methods.dart';
import 'package:food_delivery/utils/repos/auth_repo.dart';
import 'package:food_delivery/utils/repos/firestore_repo.dart';

class CartListState extends ChangeNotifier {
  CartListState() {
    storeInstance = services<FirestoreRepos>();
  }
  bool isLoadingLocal = false;
  bool isListEmtyLocal = true;
  String? repoErrorMessageLocal;
  late FirestoreRepos storeInstance;

  List<ShoppingCardModel> shoppingCartList = [];

  List<ShoppingCardModel> get cartList => shoppingCartList;
  List<ShoppingCardModel> get globalCheckedOutList => shoppingCartList;
  bool get isLoading => isLoadingLocal;
  bool get isListEmty => isListEmtyLocal;
  int get cartListLegnth => shoppingCartList.length;

  String? get repoErrorMessage => repoErrorMessageLocal;

  addCartItem(
      ShoppingCardModel shoppingCardModel, String userId, String productId) {
    isLoadingLocal = true;
    notifyListeners();
    shoppingCartList.add(shoppingCardModel);

    storeInstance.addFoodItemToShoppingList(shoppingCardModel, productId);
    isLoadingLocal = false;
    notifyListeners();
  }

  Future<bool> aleadyInTheList(String userId, String productIdToTest) {
    return storeInstance.isAlreadyInTheList(productIdToTest);
  }

  Future<List<ShoppingCardModel>> getCartListProducts() async {
    List<ShoppingCardModel> list = [];
    if (services<AuthRepos>().userId != null) {
      list = Methods.decodeCartListDquerySnap(
          await storeInstance.getShoppingCartList());
      shoppingCartList = list;
      notifyListeners();
    }
    return list;
  }

  Future<void> deleteShoppingCartListItems(userId) async {
    services<FirestoreRepos>().removedShoppingCartItems(userId).then((_) {
      shoppingCartList.clear();
      print('Items removed');
      notifyListeners();
    });
  }

  changeProductQuantity(ShoppingCardModel shoppingCardModel, int newQuintity) {
    shoppingCartList[shoppingCartList.indexOf(shoppingCardModel)].quantity =
        newQuintity;
    notifyListeners();
  }

  Future<bool> deleteACartItem(String itemId) async {
    isLoadingLocal = true;
    notifyListeners();
    String responce = await storeInstance.removeACertItem(itemId);
    if (responce == 'OK') {
      isLoadingLocal = false;
      notifyListeners();
      return true;
    } else {
      repoErrorMessageLocal = responce;
      isLoadingLocal = false;
      notifyListeners();
      return false;
    }
  }
}
