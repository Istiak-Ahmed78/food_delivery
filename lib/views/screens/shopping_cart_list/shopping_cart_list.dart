import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/models/shopping_card_item_model.dart';
import 'package:food_delivery/state_management/cart_list_state.dart';
import 'package:food_delivery/utils/repos/auth_repo.dart';
import 'package:food_delivery/views/screens/order_details/order_details.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:provider/provider.dart';
import '../../../di_containers.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartState();
}

class _CartState extends State<CartScreen> {
  double checkOutAmount = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPersistentFrameCallback((timeStamp) {
      Provider.of<CartListState>(context, listen: false)
          .getCartListProducts(services<AuthRepos>().getCurrentUser()!.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ShoppingCardModel> shoppingCartList =
        Provider.of<CartListState>(context).cartList;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: ColorResources.black),
        ),
        title: const Text(
          'Cart',
          style: TextStyle(color: ColorResources.orange),
        ),
        centerTitle: true,
        backgroundColor: ColorResources.white,
        elevation: 0.0,
      ),
      backgroundColor: ColorResources.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 112),
              child: SingleChildScrollView(
                child: Column(children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.shopping_bag,
                        color: ColorResources.blueGrey,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Shopping Card',
                            style: TextStyle(
                                color: ColorResources.blueGrey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: Strings.notosansFontFamilly),
                          ),
                          Text(
                            'Verify your quantity and click checkout',
                            style: TextStyle(
                                color:
                                    ColorResources.blueGrey.withOpacity(0.6)),
                          )
                        ],
                      )
                    ],
                  ),
                  const ShoppingCardListWidget()
                ]),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 112,
                color: ColorResources.white,
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Subtotal',
                          style: TextStyle(
                              fontFamily: Strings.notosansFontFamilly),
                        ),
                        Text('${subtotal(shoppingCartList)}')
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'TAX(10.0%)',
                          style: TextStyle(
                              fontFamily: Strings.notosansFontFamilly),
                        ),
                        Text('${tax(subtotal(shoppingCartList))}')
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      color: ColorResources.orange,
                      minWidth: double.infinity,
                      height: 50,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      onPressed: () {
                        if (Provider.of<CartListState>(context, listen: false)
                            .cartList
                            .isNotEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderDetailsScreen(
                                        checkOutvale: checkOutBalance(
                                            subtotal(shoppingCartList)),
                                      )));
                        } else {
                          showToast(context, 'Add at least one Item');
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          const Text(
                            'Checkout',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorResources.white),
                          ),
                          Text(
                            '\$${checkOutBalance(subtotal(shoppingCartList))}',
                            style: const TextStyle(
                                color: ColorResources.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double subtotal(List<ShoppingCardModel> shoppingCartModelList) {
    double value = 0.0;
    for (final i in shoppingCartModelList) {
      value = value + i.trendingFoodModel.price * i.quantity;
    }
    return value.roundToDouble();
  }

  double tax(double subtotal) => (subtotal * 0.1).roundToDouble();
  double checkOutBalance(double subtotal) => (subtotal * 0.9).roundToDouble();
}

class ShoppingCardListWidget extends StatelessWidget {
  const ShoppingCardListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartListProvider = Provider.of<CartListState>(context, listen: false);
    cartListProvider
        .getCartListProducts(services<AuthRepos>().getCurrentUser()!.uid);
    return SizedBox(
        child: cartListProvider.cartList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => ShoppingCartItem(
                  shoppingCartModel: cartListProvider.cartList[index],
                ),
                itemCount: cartListProvider.cartList.length,
                shrinkWrap: true,
              ));
  }
}

class ShoppingCartItem extends StatefulWidget {
  final ShoppingCardModel shoppingCartModel;
  const ShoppingCartItem({Key? key, required this.shoppingCartModel})
      : super(key: key);

  @override
  State<ShoppingCartItem> createState() => _ShoppingCartItemState();
}

class _ShoppingCartItemState extends State<ShoppingCartItem> {
  int quantityOfProduct = 1;
  @override
  void initState() {
    super.initState();
    quantityOfProduct = widget.shoppingCartModel.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget
                                .shoppingCartModel.trendingFoodModel.imageUrl),
                            fit: BoxFit.cover),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    height: 70,
                    width: 70,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.shoppingCartModel.trendingFoodModel.title,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorResources.blueGrey,
                            fontSize: 15),
                      ),
                      Text(
                        '\$${widget.shoppingCartModel.trendingFoodModel.price.toString()}',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: Strings.notosansFontFamilly),
                      )
                    ],
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          quantityOfProduct++;
                        });
                        Provider.of<CartListState>(context, listen: false)
                            .changeProductQuantity(
                                widget.shoppingCartModel, quantityOfProduct);
                      },
                      child: const Icon(Icons.control_point)),
                  Text(quantityOfProduct.toString()),
                  GestureDetector(
                      onTap: () {
                        if (quantityOfProduct > 1) {
                          quantityOfProduct--;
                          Provider.of<CartListState>(context, listen: false)
                              .changeProductQuantity(
                                  widget.shoppingCartModel, quantityOfProduct);
                        }
                      },
                      child: const Icon(Icons.remove_circle_outline)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
