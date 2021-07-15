import 'package:flutter/material.dart';
import 'package:food_delivery/views/styles/colors.dart';

const kNotosans = 'NotoSans';
const dummyText =
    ' Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.';
const avaterImageLink =
    'https://scontent.fjsr1-1.fna.fbcdn.net/v/t1.18169-9/18275046_677048639150149_1874779649391374464_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=09cbfe&_nc_eui2=AeELzbjwUO2w4sgff3UY_flSisYu3-UNCMWKxi7f5Q0IxVGneOzjbje2SXFURB3s52EJV-ZK6XRG-w3TfgOywim9&_nc_ohc=2AMWzJUs_WgAX9ZsEWE&_nc_ht=scontent.fjsr1-1.fna&oh=53575930cc34929d69e8855e5ddea684&oe=60EB1C2A';
void showToast(BuildContext context, String toastMessage) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      toastMessage,
      style: const TextStyle(color: kGrey),
    ),
    backgroundColor: kWhite,
    duration: const Duration(seconds: 2),
  ));
}
