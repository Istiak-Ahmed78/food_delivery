import 'package:flutter/material.dart';
import 'package:food_delivery/views/styles/colors.dart';

const dummyText =
    ' Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.';

enum DelivertyStatus { orderPlaced, inTheKitchen, onTheWay, delivered }

void showToast(BuildContext context, String toastMessage) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      toastMessage,
      style: const TextStyle(color: ColorResources.grey),
    ),
    backgroundColor: ColorResources.white,
    duration: const Duration(seconds: 2),
  ));
}

class Sectrets {
  static const googleMapApiKey = 'AIzaSyBRzY2-SBH3eRF0YOoKjSyAv5qEzv_Sk0I';
  static const isFirstLaunchKey = 'isWelcome';
}

class Strings {
  static const notosansFontFamilly = 'NotoSans';

  //Password Strenth
  static const strongPassword = 'Strong password';
  static const mediumPassword = 'Medium';
  static const weakPassword = 'Your password is weak';

  //Model keys
  static const productImage = 'Image Address';
  static const productPrice = 'Price';
  static const weight = 'Weight';
  static const productTitle = 'Title';
}

class FiresoreKeys {
  //Firestore map keys
  static const productCollectionKey = 'Products';
  static const homeProducts = 'Home Products';
  static const sectionKey = 'sections';
  static const sectionFoodKey = 'Sections Food';
  static const foodHeaderListDetailsKey = 'Food list header details';
  static const shoppingCartListKey = 'Shopping Cart List';
  static const cartListKey = 'Cart List';
  static const orderedListKey = 'Ordered list';
  static const indivitualOrderedListKey = 'ordered list';
  static const orderInfoKey = 'Order Informations';
}

class FirebaseErrorMessage {
  static const defaultMessage = 'Something went wrong';
  static const emailIsNotVerified = 'Your email is not verified';
}

class Images {
  //Asset Images
  static const logInDeliveryMan = 'assets/images/moto.png';
  static const googleLogo = 'assets/images/google.png';
  static const facebookLogo = 'assets/images/facebook.png';
  static const cooking = 'assets/images/cooking.png';
  static const verifyEmail = 'assets/images/verify_email.png';
  static const avaterImageLogo = 'assets/images/avater.png';
  static const noItem = 'assets/images/no_item.png';

  //Network Images
  static const avaterImageLink =
      'https://scontent.fjsr1-1.fna.fbcdn.net/v/t1.18169-9/18275046_677048639150149_1874779649391374464_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=09cbfe&_nc_eui2=AeELzbjwUO2w4sgff3UY_flSisYu3-UNCMWKxi7f5Q0IxVGneOzjbje2SXFURB3s52EJV-ZK6XRG-w3TfgOywim9&_nc_ohc=2AMWzJUs_WgAX9ZsEWE&_nc_ht=scontent.fjsr1-1.fna&oh=53575930cc34929d69e8855e5ddea684&oe=60EB1C2A';
  static const breadImage =
      'https://www.seriouseats.com/thmb/zt2uPceCGgDY7TjetsQy74LL4aE=/1500x1125/filters:fill(auto,1)/__opt__aboutcom__coeus__resources__content_migration__serious_eats__seriouseats.com__2011__06__20200419-no-knead-bread-vicky-wasik2-a20f97803cb349e38c2c3fad18f767b5.jpg';
}

class FormValidatorMessage {
  static const emtyFieldErrorMessage = 'This field is required';
}
