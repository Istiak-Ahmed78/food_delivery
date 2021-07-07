import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/models/food_model.dart';
import 'package:food_delivery/models/nutrition.dart';
import 'package:food_delivery/models/shopping_card_item_model.dart';
import 'package:food_delivery/state_management/cart_list_state.dart';
import 'package:food_delivery/views/screens/cart/cart_screen.dart';
import 'package:food_delivery/views/screens/product_deatils_screen/components/components.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                                  color: kBlueGrey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: kNotosans),
                            ),
                            Text(
                              '\$${trendingFoodModel.price}',
                              style: const TextStyle(
                                  color: kRed,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontFamily: kNotosans),
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
                            style: TextStyle(color: kGrey, fontSize: 12),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          dummyText,
                          style: TextStyle(color: kGrey),
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
                                  color: kBlueGrey, fontFamily: kNotosans),
                            ),
                            leading: Icon(
                              Icons.add_circle_outline,
                              color: kBlueGrey,
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
                color: kWhite,
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
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, color: kOrange),
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
                        color: kWhite,
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
                          backgroundColor: kRed,
                          child: Text(
                            Provider.of<CartList>(context)
                                .cartList
                                .length
                                .toString(),
                            style: const TextStyle(color: kWhite, fontSize: 10),
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
        style: const TextStyle(color: kBlack),
      ),
      backgroundColor: kWhite,
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
                    fontFamily: kNotosans, fontSize: 20, color: kGrey)),
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
                  color: kBlueGrey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  productQuantity.toDouble().toString(),
                  style:
                      const TextStyle(fontFamily: kNotosans, color: kBlueGrey),
                ),
              ),
              InkWell(
                onTap: () => setState(() {
                  productQuantity++;
                }),
                child: const Icon(
                  Icons.add_circle_outline,
                  color: kBlueGrey,
                ),
              ),
            ])
          ],
        ),
        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kOrange, width: 1),
              ),
              child: const Icon(
                Icons.favorite,
                color: kOrange,
              ),
            ),
            Expanded(
              flex: 5,
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: kOrange,
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
                              color: kWhite,
                              fontFamily: kNotosans,
                              fontSize: 15),
                        ),
                        Text(
                          '\$$checkOutBalance',
                          style: const TextStyle(
                              fontSize: 15,
                              color: kWhite,
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
              color: kBlueGrey,
              fontFamily: kNotosans,
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
              style: TextStyle(color: kGrey.withOpacity(0.5)),
            ),
            Text(nutritionValue.toString(),
                style: const TextStyle(fontSize: 20, fontFamily: kNotosans))
          ],
        ),
      ),
    );
  }
}
