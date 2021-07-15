import 'food_model.dart';

class ShoppingCardModel {
  final FoodModel trendingFoodModel;
  int quantity;

  ShoppingCardModel(this.trendingFoodModel, this.quantity);
  static List<ShoppingCardModel> shopppingList = [
    for (final everyItem in FoodModel.trendinFoodList)
      ShoppingCardModel(everyItem, 0)
  ];
}
