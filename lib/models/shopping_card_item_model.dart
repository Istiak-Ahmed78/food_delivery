import 'food_model.dart';

class ShoppingCardModel {
  final FoodModel foodModel;
  int quantity;

  ShoppingCardModel({required this.foodModel, required this.quantity});
  static List<ShoppingCardModel> shopppingList = [
    for (final everyItem in FoodModel.trendinFoodList)
      ShoppingCardModel(foodModel: everyItem, quantity: 0)
  ];

  factory ShoppingCardModel.fromMap(Map<String, dynamic> mapedData) {
    return ShoppingCardModel(
        quantity: mapedData['Quantity'],
        foodModel: FoodModel(
            imageUrl: mapedData['Image Address'],
            price: (mapedData['Price']) as double,
            weight: mapedData['Weight'],
            title: mapedData['Title'],
            productId: mapedData['Product Id']));
  }
  static Map<String, dynamic> toMap(ShoppingCardModel shoppingCardModel) {
    return {
      'Quantity': shoppingCardModel.quantity,
      'Price': shoppingCardModel.foodModel.price,
      'Weight': shoppingCardModel.foodModel.weight,
      'Product Id': shoppingCardModel.foodModel.productId,
      'Image Address': shoppingCardModel.foodModel.imageUrl,
      'Title': shoppingCardModel.foodModel.title
    };
  }
}
