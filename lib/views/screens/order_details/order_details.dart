import 'package:flutter/material.dart';
import 'package:food_delivery/utils/form_validation.dart';
import 'package:food_delivery/views/screens/checkout/check_out_screen.dart';
import 'package:food_delivery/views/shared_widgets/shared_widgets.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order details',
          style: TextStyle(color: ColorResources.red),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorResources.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: ColorResources.white,
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
                      color: ColorResources.blueGrey,
                      fontSize: 20,
                      fontFamily: Strings.notosansFontFamilly),
                ),
                DefaultFormFlield(
                  controller: fullNameController,
                  hintText: 'Full name',
                  maxLenth: 25,
                  validator: (value) {
                    if (value == null || value == '') {
                      return 'Full name field requred';
                    } else if (value.length < 7) {
                      return 'Enter your full name';
                    } else {
                      return null;
                    }
                  },
                ),
                DefaultFormFlield(
                    controller: adressController,
                    hintText: 'Your Full Adress',
                    maxLenth: 50,
                    maxLine: 2,
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'Full name field requred';
                      } else {
                        return null;
                      }
                    }),
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
                      color: ColorResources.black,
                      fontFamily: Strings.notosansFontFamilly),
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorResources.blueGrey)),
                      hintText: 'Phone Number',
                      helperStyle: TextStyle(color: ColorResources.blueGrey)),
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
                                color: ColorResources.white,
                                fontFamily: Strings.notosansFontFamilly),
                          ),
                          const Icon(
                            Icons.navigate_next,
                            color: ColorResources.white,
                          ),
                        ],
                      ),
                      buttonColor: ColorResources.orange,
                      onPressed: () {
                        if (orderFormKey.currentState!.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckoutScreen(
                                        checkOutValue: widget.checkOutvale,
                                      )));
                        }
                      },
                    )
                    //  MaterialButton(
                    //   minWidth: double.infinity,
                    //   height: 50,
                    //   shape: const RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.all(Radius.circular(20))),
                    // onPressed: () {
                    //   if (orderFormKey.currentState!.validate()) {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => CheckoutScreen(
                    //                   checkOutValue: widget.checkOutvale,
                    //                 )));
                    //   }
                    //   },
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Container(),
                    //       const Text(
                    //         'Next',
                    //         style: TextStyle(
                    //             color: ColorResources.white,
                    //             fontFamily: Strings.notosansFontFamilly),
                    //       ),
                    //       const Icon(
                    //         Icons.navigate_next,
                    //         color: ColorResources.white,
                    //       ),
                    //     ],
                    //   ),
                    //   color: ColorResources.orange,
                    // ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
