import 'package:food_delivery/models/shopping_card_item_model.dart';

class OrderInformationModel {
  final String? fullName, fullAddress, emailAddress, phoneNumber;
  final List<ShoppingCardModel>? shoppingCardModelList;

  OrderInformationModel(
      {this.fullName,
      this.fullAddress,
      this.emailAddress,
      this.phoneNumber,
      this.shoppingCardModelList});
}
