import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/di_containers.dart';
import 'package:food_delivery/models/ordered_info_model.dart';
import 'package:food_delivery/models/shopping_card_item_model.dart';
import 'package:food_delivery/utils/repos/auth_repo.dart';

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

  Future<void> addFoodItemToShoppingList(
          ShoppingCardModel shoppingCardModel, String productId) =>
      firestoreInstance
          .collection(FiresoreKeys.shoppingCartListKey)
          .doc(services<AuthRepos>().userId)
          .collection(FiresoreKeys.cartListKey)
          .doc(productId)
          .set({
        'Product Id': productId,
        'Image Adress': shoppingCardModel.foodModel.imageUrl,
        'Title': shoppingCardModel.foodModel.title,
        'Price': shoppingCardModel.foodModel.price,
        'Weight': shoppingCardModel.foodModel.weight,
        'Quantity': shoppingCardModel.quantity
      });

  Future<bool> isAlreadyInTheList(productIdToTest) async {
    return (await getShoppingCartList()).docs.contains(productIdToTest);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getShoppingCartList() async {
    return firestoreInstance
        .collection(FiresoreKeys.shoppingCartListKey)
        .doc(services<AuthRepos>().userId)
        .collection(FiresoreKeys.cartListKey)
        .get();
  }

  Future<String> removeACertItem(itemId) {
    return firestoreInstance
        .collection(FiresoreKeys.shoppingCartListKey)
        .doc(services<AuthRepos>().userId)
        .collection(FiresoreKeys.cartListKey)
        .doc(itemId)
        .delete()
        .then((_) => 'OK')
        .onError((s, _) => s.toString());
  }

  Future<void> removedShoppingCartItems(
    userID,
  ) async {
    CollectionReference collectionReference = firestoreInstance
        .collection(FiresoreKeys.shoppingCartListKey)
        .doc(services<AuthRepos>().userId)
        .collection(FiresoreKeys.cartListKey);
    for (final i in (await collectionReference.get()).docs) {
      collectionReference.doc(i.id).delete();
    }
  }

  Future<void> addOrdedList(
      userId, time, List<ShoppingCardModel> dataToSet) async {
    for (final i in dataToSet) {
      firestoreInstance
          .collection(FiresoreKeys.orderedListKey)
          .doc(userId)
          .collection(FiresoreKeys.indivitualOrderedListKey)
          .doc(time)
          .set(ShoppingCardModel.toMap(i));
    }
  }

  Future<void> setOrderDetails(
      userId, orderId, OrderedInfoModel orderInformationModel) async {
    return firestoreInstance
        .collection(FiresoreKeys.orderedListKey)
        .doc(userId)
        .collection(FiresoreKeys.orderInfoKey)
        .doc(orderId)
        .set(OrderedInfoModel.toMap(orderInformationModel));
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getOrderedList() {
    return firestoreInstance
        .collection(FiresoreKeys.orderedListKey)
        .doc(services<AuthRepos>().userId)
        .collection(FiresoreKeys.indivitualOrderedListKey)
        .get();
  }
}
