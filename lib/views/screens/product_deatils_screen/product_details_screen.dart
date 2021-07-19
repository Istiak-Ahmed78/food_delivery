import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/models/food_model.dart';
import 'package:food_delivery/models/nutrition.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/models/restaurant_model.dart';
import 'package:food_delivery/models/shopping_card_item_model.dart';
import 'package:food_delivery/state_management/cart_list_state.dart';
import 'package:food_delivery/state_management/favorite_list_state.dart';
import 'package:food_delivery/views/screens/product_deatils_screen/components/components.dart';
import 'package:food_delivery/views/screens/shopping_cart_list/shopping_cart_list.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class ProductDetailsScreen extends StatelessWidget {
  final FoodModel trendingFoodModel;
  const ProductDetailsScreen({Key? key, required this.trendingFoodModel})
      : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 125),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(trendingFoodModel.imageUrl),
                          fit: BoxFit.cover),
                    ),
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: double.infinity,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              trendingFoodModel.title,
                              style: const TextStyle(
                                  color: ColorResources.blueGrey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Strings.notosansFontFamilly),
                            ),
                            Text(
                              '\$${trendingFoodModel.price}',
                              style: const TextStyle(
                                  color: ColorResources.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontFamily: Strings.notosansFontFamilly),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '300 g',
                            style: TextStyle(
                                color: ColorResources.grey, fontSize: 12),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          dummyText,
                          style: TextStyle(color: ColorResources.grey),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            bottom: 0.0,
                          ),
                          child: ListTile(
                            title: Text(
                              'Extra',
                              style: TextStyle(
                                  color: ColorResources.blueGrey,
                                  fontFamily: Strings.notosansFontFamilly),
                            ),
                            leading: Icon(
                              Icons.add_circle_outline,
                              color: ColorResources.blueGrey,
                            ),
                            subtitle:
                                Text('Select extra to add them on the food'),
                          ),
                        ),
                        SizedBox(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => ExtraItem(
                                foodModel: FoodModel.extraFoodList[index]),
                            itemCount: FoodModel.extraFoodList.length,
                            shrinkWrap: true,
                          ),
                        ),
                        const NutritionsPart()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 10,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: ColorResources.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: 30,
            right: 20,
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: ColorResources.orange),
              height: 50,
              width: 50,
              padding: const EdgeInsets.only(right: 7),
              child: Stack(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.shoppingCart,
                        size: 18,
                        color: ColorResources.white,
                      )),
                  Positioned(
                    right: 2,
                    top: 25,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CartScreen()));
                      },
                      child: CircleAvatar(
                          radius: 8,
                          backgroundColor: ColorResources.red,
                          child: Text(
                            Provider.of<CartList>(context)
                                .cartList
                                .length
                                .toString(),
                            style: const TextStyle(
                                color: ColorResources.white, fontSize: 10),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  padding: const EdgeInsets.all(15),
                  height: 122,
                  child: AddtoCardButton(
                    foodModel: trendingFoodModel,
                  )))
        ],
      ),
    );
  }
}

class AddtoCardButton extends StatefulWidget {
  final FoodModel foodModel;
  const AddtoCardButton({Key? key, required this.foodModel}) : super(key: key);

  @override
  State<AddtoCardButton> createState() => _AddtoCardButtonState();
}

class _AddtoCardButtonState extends State<AddtoCardButton> {
  void showToast(String toastMessage) {
    var snackBar = SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(
        toastMessage,
        style: const TextStyle(color: ColorResources.black),
      ),
      backgroundColor: ColorResources.white,
      elevation: 5,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  int productQuantity = 1;
  @override
  Widget build(BuildContext context) {
    double checkOutBalance =
        (widget.foodModel.price * productQuantity).roundToDouble();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Quantity',
                style: TextStyle(
                    fontFamily: Strings.notosansFontFamilly,
                    fontSize: 20,
                    color: ColorResources.grey)),
            Row(mainAxisSize: MainAxisSize.min, children: [
              InkWell(
                onTap: () {
                  if (productQuantity > 1) {
                    setState(() {
                      productQuantity--;
                    });
                  }
                },
                child: const Icon(
                  Icons.remove_circle_outline,
                  color: ColorResources.blueGrey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  productQuantity.toDouble().toString(),
                  style: const TextStyle(
                      fontFamily: Strings.notosansFontFamilly,
                      color: ColorResources.blueGrey),
                ),
              ),
              InkWell(
                onTap: () => setState(() {
                  productQuantity++;
                }),
                child: const Icon(
                  Icons.add_circle_outline,
                  color: ColorResources.blueGrey,
                ),
              ),
            ])
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                bool isAleadyInTheList =
                    Provider.of<FavoriteFoodItems>(context, listen: false)
                        .favList
                        .where((element) =>
                            element.restaurentListItemModel.title ==
                            widget.foodModel.title)
                        .toList()
                        .isEmpty;
                if (isAleadyInTheList) {
                  Provider.of<FavoriteFoodItems>(context, listen: false).addFav(
                      OrderModel(
                          restaurentListItemModel: RestaurentListItemModel(
                              title: widget.foodModel.title,
                              price: widget.foodModel.price,
                              imageAdress: widget.foodModel.imageUrl,
                              rating: 4,
                              subTitle: dummyText)));
                  showToast('This item added to the wishlist');
                } else {
                  showToast('This Item already in the wishlist');
                }
              },
              child: Container(
                height: 40,
                width: 40,
                margin: const EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorResources.orange, width: 1),
                ),
                child: const Icon(
                  Icons.favorite,
                  color: ColorResources.orange,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: ColorResources.orange,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24)))),
                    onPressed: () {
                      bool isAleadyInTheList =
                          Provider.of<CartList>(context, listen: false)
                              .cartList
                              .where((element) =>
                                  element.trendingFoodModel == widget.foodModel)
                              .toList()
                              .isEmpty;
                      if (isAleadyInTheList) {
                        Provider.of<CartList>(context, listen: false)
                            .addCartItem(ShoppingCardModel(
                                widget.foodModel, productQuantity));
                        showToast('Added');
                      } else {
                        showToast('The Item already extists');
                        print('The Item already extists');
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Add to Cart',
                          style: TextStyle(
                              color: ColorResources.white,
                              fontFamily: Strings.notosansFontFamilly,
                              fontSize: 15),
                        ),
                        Text(
                          '\$$checkOutBalance',
                          style: const TextStyle(
                              fontSize: 15,
                              color: ColorResources.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
              ),
            )
          ],
        )
      ],
    );
  }
}

class NutritionsPart extends StatelessWidget {
  const NutritionsPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(children: [
        const ListTile(
          leading: Icon(Icons.stars),
          title: Text(
            'Nutritions',
            style: TextStyle(
              color: ColorResources.blueGrey,
              fontFamily: Strings.notosansFontFamilly,
            ),
          ),
        ),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 120,
              mainAxisSpacing: 20,
              childAspectRatio: 3 / 2),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => GridVeiwItem(
            nutritionKey: nutritions.keys.toList()[index],
            nutritionValue: nutritions.values.toList()[index],
          ),
          itemCount: nutritions.length,
        )
      ]),
    );
  }
}

class GridVeiwItem extends StatelessWidget {
  final String nutritionKey;
  final double nutritionValue;
  const GridVeiwItem(
      {Key? key, required this.nutritionKey, required this.nutritionValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              nutritionKey,
              style: TextStyle(color: ColorResources.grey.withOpacity(0.5)),
            ),
            Text(nutritionValue.toString(),
                style: const TextStyle(
                    fontSize: 20, fontFamily: Strings.notosansFontFamilly))
          ],
        ),
      ),
    );
  }
}
