import 'package:flutter/material.dart';
import 'package:food_delivery/views/styles/colors.dart';

class SearchRestaurant extends StatefulWidget {
  const SearchRestaurant({Key? key}) : super(key: key);

  @override
  State<SearchRestaurant> createState() => _SearchRestaurantState();
}

class _SearchRestaurantState extends State<SearchRestaurant> {
  var editingCintroller = TextEditingController();

  InputDecoration inputDecoration = InputDecoration(
      hintText: 'Search for restaurant or foods',
      hintStyle: const TextStyle(color: kGrey),
      prefixIcon: const Icon(
        Icons.search,
        color: kOrange,
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kGrey.withOpacity(0.6))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kGrey.withOpacity(0.2))));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: editingCintroller,
        decoration: inputDecoration,
      ),
    );
  }
}