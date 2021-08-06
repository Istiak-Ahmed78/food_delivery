import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/di_containers.dart';
import 'package:food_delivery/models/shopping_card_item_model.dart';
import 'package:food_delivery/state_management/cart_list_state.dart';
import 'package:food_delivery/utils/methods.dart';
import 'package:food_delivery/utils/repos/firestore_repo.dart';
import 'package:food_delivery/views/screens/order_details/order_details.dart';
import 'package:food_delivery/views/shared_widgets/shared_widgets.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:provider/provider.dart';

import 'components.dart/components.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<CartListState>(context, listen: false).getCartListProducts();
    List<ShoppingCardModel> shoppingCartList =
        Provider.of<CartListState>(context, listen: false).cartList;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: CResources.black),
        ),
        title: const Text(
          'Cart',
          style: TextStyle(color: CResources.orange),
        ),
        centerTitle: true,
        backgroundColor: CResources.white,
        elevation: 0.0,
      ),
      backgroundColor: CResources.white,
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
                        color: CResources.blueGrey,
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
                                color: CResources.blueGrey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: Strings.notosansFontFamilly),
                          ),
                          Text(
                            'Verify your quantity and click checkout',
                            style: TextStyle(
                                color: CResources.blueGrey.withOpacity(0.6)),
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
                color: CResources.white,
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
                      color: CResources.orange,
                      minWidth: double.infinity,
                      height: 50,
                      disabledColor: CResources.grey,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      onPressed: Provider.of<CartListState>(context).isListEmty
                          ? null
                          : () {
                              if (Provider.of<CartListState>(context,
                                      listen: false)
                                  .cartList
                                  .isNotEmpty) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OrderDetailsScreen(
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
                                color: CResources.white),
                          ),
                          Text(
                            '\$${checkOutBalance(subtotal(shoppingCartList))}',
                            style: const TextStyle(
                                color: CResources.white,
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
      value = value + i.foodModel.price * i.quantity;
    }
    return value.roundToDouble();
  }

  double tax(double subtotal) => (subtotal * 0.1).roundToDouble();
  double checkOutBalance(double subtotal) => (subtotal * 1.1).roundToDouble();
}

class ShoppingCardListWidget extends StatelessWidget {
  const ShoppingCardListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: FutureBuilder(
      future: services<FirestoreRepos>().getShoppingCartList(),
      builder:
          (_, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            Provider.of<CartListState>(context, listen: false).isListEmtyLocal =
                true;
            return const EmtyListWidget();
          } else {
            var data = Methods.decodeCartListDquerySnap(snapshot.data!);
            Provider.of<CartListState>(context, listen: false).isListEmtyLocal =
                false;
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => ShoppingCartItem(
                shoppingCartModel: data[index],
              ),
              itemCount: data.length,
              shrinkWrap: true,
            );
          }
        } else {
          return const LoadingShimmerWidget();
        }
      },
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
    return Dismissible(
      key: Key(widget.shoppingCartModel.foodModel.productId),
      onDismissed: (_) async {
        var tempcartProvider =
            Provider.of<CartListState>(context, listen: false);
        Methods.showLoadingIndicator(
            context: context,
            workTodo: tempcartProvider
                .deleteACartItem(widget.shoppingCartModel.foodModel.productId));

        if (await tempcartProvider
            .deleteACartItem(widget.shoppingCartModel.foodModel.productId)) {
          Methods.showToast(toastMessage: 'Successfully removed');
        } else {
          Methods.showToast(
              toastMessage: tempcartProvider.repoErrorMessage ??
                  FirebaseErrorMessage.defaultMessage);
        }
      },
      child: Container(
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
                              image: NetworkImage(
                                  widget.shoppingCartModel.foodModel.imageUrl),
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
                          widget.shoppingCartModel.foodModel.title,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CResources.blueGrey,
                              fontSize: 15),
                        ),
                        Text(
                          '\$${widget.shoppingCartModel.foodModel.price.toString()}',
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
                                .changeProductQuantity(widget.shoppingCartModel,
                                    quantityOfProduct);
                          }
                        },
                        child: const Icon(Icons.remove_circle_outline)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
