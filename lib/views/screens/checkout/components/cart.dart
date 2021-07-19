import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:date_format/date_format.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late TextEditingController cartNumberController;
  late TextEditingController dateController;
  late TextEditingController cvvController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cartNumberController = TextEditingController(text: '4242 4243 6390 0050');
    dateController = TextEditingController(text: '12/23');
    cvvController = TextEditingController(text: '567');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          color: ColorResources.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/visa.jpg'),
                  fit: BoxFit.cover,
                )),
                height: 40,
                width: 60,
              ),
              TextButton(
                  onPressed: () {
                    showEditCartDialog(context);
                  },
                  child: const Text('Edit',
                      style: TextStyle(
                          fontFamily: Strings.notosansFontFamilly,
                          color: ColorResources.blueGrey)))
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'CARD NUMBER',
                style: TextStyle(
                    color: ColorResources.grey,
                    fontFamily: Strings.notosansFontFamilly),
              ),
              Text(
                cartNumberController.text,
                style: const TextStyle(
                    color: ColorResources.blueGrey,
                    fontSize: 17,
                    letterSpacing: 2),
              )
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'EXPIRY DATE',
                    style: TextStyle(
                        color: ColorResources.grey,
                        fontFamily: Strings.notosansFontFamilly),
                  ),
                  Text(
                    'CVV',
                    style: TextStyle(
                        color: ColorResources.grey,
                        fontFamily: Strings.notosansFontFamilly),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dateController.text,
                    style: const TextStyle(
                        color: ColorResources.blueGrey,
                        fontFamily: Strings.notosansFontFamilly),
                  ),
                  Text(
                    cvvController.text,
                    style: const TextStyle(
                        color: ColorResources.blueGrey,
                        fontFamily: Strings.notosansFontFamilly),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration inputDecoration(labeltext) => InputDecoration(
      focusColor: ColorResources.black,
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorResources.black)),
      labelText: labeltext,
      labelStyle: const TextStyle(
          color: ColorResources.black,
          fontFamily: Strings.notosansFontFamilly));

  showEditCartDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                  children: [
                    TextField(
                      controller: cartNumberController,
                      keyboardType: TextInputType.number,
                      decoration: inputDecoration('Number'),
                    ),
                    TextField(
                      controller: dateController,
                      readOnly: true,
                      onTap: () async {
                        DateTime currentDate = await pickDateTime(context);
                        setState(() {
                          dateController.text =
                              formatDate(currentDate, [mm, '/', yy]);
                        });
                      },
                      keyboardType: TextInputType.datetime,
                      decoration: inputDecoration('Exp Date'),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: cvvController,
                      decoration: inputDecoration('CVC'),
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Save',
                        style: TextStyle(
                            fontFamily: Strings.notosansFontFamilly))),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                          fontFamily: Strings.notosansFontFamilly,
                          color: ColorResources.red),
                    ))
              ],
              title: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.person),
                  ),
                  Text(
                    'Payment Settings',
                    style: TextStyle(
                        color: ColorResources.blueGrey,
                        fontFamily: Strings.notosansFontFamilly),
                  ),
                ],
              ),
            ));
  }

  Future<DateTime> pickDateTime(BuildContext context) async {
    DateTime? pickedTime =
        await showMonthPicker(context: context, initialDate: DateTime.now());
    //  await showDatePicker(
    //     context: context,
    //     initialDate: DateTime(2020, 2),
    //     firstDate: DateTime(2020, 2),
    //     lastDate: DateTime(2028, 2));
    return pickedTime ?? DateTime(2022, 4);
  }
}
