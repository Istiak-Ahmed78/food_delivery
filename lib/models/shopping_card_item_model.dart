import 'food_model.dart';

class ShoppingCardModel {
  final FoodModel trendingFoodModel;
  int quantity;

  ShoppingCardModel({required this.trendingFoodModel, required this.quantity});
  static List<ShoppingCardModel> shopppingList = [
    for (final everyItem in FoodModel.trendinFoodList)
      ShoppingCardModel(trendingFoodModel: everyItem, quantity: 0)
  ];

  factory ShoppingCardModel.fromMap(Map<String, dynamic> mapedData) {
    return ShoppingCardModel(
        quantity: mapedData['Quantity'],
        trendingFoodModel: FoodModel(
            imageUrl: mapedData['Image Adress'],
            price: (mapedData['Price']) as double,
            weight: mapedData['Weight'],
            title: mapedData['Title'],
            productId: mapedData['Product Id']));
  }
}
