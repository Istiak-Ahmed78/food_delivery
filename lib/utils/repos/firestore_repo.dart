import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/models/shopping_card_item_model.dart';

class FirestoreRepos {
  FirestoreRepos() {
    firestoreInstance = FirebaseFirestore.instance;
  }
  late FirebaseFirestore firestoreInstance;

  Future<QuerySnapshot<Map<String, dynamic>>> getProduts(
      String collectionId) async {
    return firestoreInstance
        .collection(FiresoreKeys.homeProducts)
        .doc(FiresoreKeys.sectionKey)
        .collection(collectionId)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>>
      getProductSectionHeadings() async {
    return firestoreInstance
        .collection(FiresoreKeys.foodHeaderListDetailsKey)
        .get();
  }

  Future<void> addFoodItemToShoppingList(ShoppingCardModel shoppingCardModel,
          String userId, String productId) =>
      firestoreInstance
          .collection(FiresoreKeys.shoppingCartListKey)
          .doc(userId)
          .collection(FiresoreKeys.cartListKey)
          .doc(productId)
          .set({
        'Product Id': productId,
        'Image Adress': shoppingCardModel.trendingFoodModel.imageUrl,
        'Title': shoppingCardModel.trendingFoodModel.title,
        'Price': shoppingCardModel.trendingFoodModel.price,
        'Weight': shoppingCardModel.trendingFoodModel.weight,
        'Quantity': shoppingCardModel.quantity
      });

  Future<bool> isAlreadyInTheList(userId, productIdToTest) async =>
      (await getShoppingCartList(userId))
          .docs
          .any((element) => element.id == productIdToTest);

  Future<QuerySnapshot<Map<String, dynamic>>> getShoppingCartList(userId) {
    return firestoreInstance
        .collection(FiresoreKeys.shoppingCartListKey)
        .doc(userId)
        .collection(FiresoreKeys.cartListKey)
        .get();
  }
}
