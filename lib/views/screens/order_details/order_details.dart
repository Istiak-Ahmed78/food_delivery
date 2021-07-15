import 'package:flutter/material.dart';
import 'package:food_delivery/views/screens/checkout/check_out_screen.dart';
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
  final formKey = GlobalKey<FormState>();
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
          style: TextStyle(color: kRed),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kBlack,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: kWhite,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                const Text(
                  'Order Information',
                  style: TextStyle(
                      color: kBlueGrey, fontSize: 20, fontFamily: kNotosans),
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
                    validator: (email) {
                      // if (value == null || value == '') {
                      //   return 'Email is required';
                      // }
                      String pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = RegExp(pattern);
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email!);
                      if (!regex.hasMatch(email)) {
                        return 'Enter valid email address';
                      } else if (email == '') {
                        return 'Email is required';
                      } else {
                        return null;
                      }
                    },
                    inputType: TextInputType.emailAddress,
                  ),
                ),
                IntlPhoneField(
                  initialCountryCode: 'BD',
                  style: const TextStyle(color: kBlack, fontFamily: kNotosans),
                  decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: kBlueGrey)),
                      hintText: 'Phone Number',
                      helperStyle: TextStyle(color: kBlueGrey)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 50,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CheckoutScreen(
                                      checkOutValue: widget.checkOutvale,
                                    )));
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        const Text(
                          'Next',
                          style:
                              TextStyle(color: kWhite, fontFamily: kNotosans),
                        ),
                        const Icon(
                          Icons.navigate_next,
                          color: kWhite,
                        ),
                      ],
                    ),
                    color: kOrange,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DefaultFormFlield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int? maxLenth;
  final TextInputType inputType;
  final int? maxLine;
  final FormFieldValidator<String>? validator;
  const DefaultFormFlield(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.maxLenth,
      required this.validator,
      this.maxLine = 1,
      this.inputType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: kBlueGrey, fontFamily: kNotosans),
      maxLength: maxLenth,
      maxLines: maxLine,
      keyboardType: inputType,
      decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kBlueGrey)),
          hintText: hintText,
          helperStyle: const TextStyle(color: kBlueGrey)),
      validator: validator,
    );
  }
}
