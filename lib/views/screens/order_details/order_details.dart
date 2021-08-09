import 'package:flutter/material.dart';
import 'package:food_delivery/models/order_information_model.dart';
import 'package:food_delivery/state_management/cart_list_state.dart';
import 'package:food_delivery/state_management/order_process_state.dart';
import 'package:food_delivery/utils/form_validation.dart';
import 'package:food_delivery/views/screens/checkout/check_out_screen.dart';
import 'package:food_delivery/views/shared_widgets/shared_widgets.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class OrderDetailsScreen extends StatefulWidget {
  final double checkOutvale;
  const OrderDetailsScreen({Key? key, required this.checkOutvale})
      : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final orderFormKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController emailAdressController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    adressController.dispose();
    emailAdressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order details',
          style: TextStyle(color: CResources.red),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: CResources.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: CResources.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: orderFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                const Text(
                  'Order Information',
                  style: TextStyle(
                      color: CResources.blueGrey,
                      fontSize: 20,
                      fontFamily: Strings.notosansFontFamilly),
                ),
                DefaultFormFlield(
                  controller: fullNameController,
                  hintText: 'Full name',
                  maxLenth: 25,
                  validator: FormValidation.valofateFullName,
                ),
                DefaultFormFlield(
                    controller: adressController,
                    hintText: 'Your Full Adress',
                    maxLenth: 50,
                    maxLine: 2,
                    validator: FormValidation.validateAdress),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: DefaultFormFlield(
                    controller: emailAdressController,
                    hintText: 'Your email adress',
                    validator: FormValidation.validateEmail,
                    inputType: TextInputType.emailAddress,
                  ),
                ),
                IntlPhoneField(
                  initialCountryCode: 'BD',
                  style: const TextStyle(
                      color: CResources.black,
                      fontFamily: Strings.notosansFontFamilly),
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CResources.blueGrey)),
                      hintText: 'Phone Number',
                      helperStyle: TextStyle(color: CResources.blueGrey)),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: DefaultButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          const Text(
                            'Next',
                            style: TextStyle(
                                color: CResources.white,
                                fontFamily: Strings.notosansFontFamilly),
                          ),
                          const Icon(
                            Icons.navigate_next,
                            color: CResources.white,
                          ),
                        ],
                      ),
                      buttonColor: CResources.orange,
                      onPressed: () {
                        if (orderFormKey.currentState!.validate()) {
                          OrderInformationModel orderInformationModel =
                              OrderInformationModel(
                                  fullName: fullNameController.text,
                                  fullAddress: fullNameController.text,
                                  emailAddress: emailAdressController.text,
                                  phoneNumber: phoneController.text,
                                  shoppingCardModelList:
                                      Provider.of<CartListState>(context,
                                              listen: false)
                                          .globalCheckedOutList);
                          Provider.of<OrderProcessState>(context, listen: false)
                                  .orderInformationModelLocal =
                              orderInformationModel;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckoutScreen(
                                        checkOutValue: widget.checkOutvale,
                                      )));
                        }
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
