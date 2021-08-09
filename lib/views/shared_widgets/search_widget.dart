import 'package:flutter/material.dart';
import 'package:food_delivery/utils/search_foods_deligate.dart';
import 'package:food_delivery/views/styles/colors.dart';

class SearchFoods extends StatefulWidget {
  const SearchFoods({Key? key}) : super(key: key);

  @override
  State<SearchFoods> createState() => _SearchFoodsState();
}

class _SearchFoodsState extends State<SearchFoods> {
  var editingCintroller = TextEditingController();

  InputDecoration inputDecoration = InputDecoration(
      hintText: 'Search for restaurant or foods',
      hintStyle: const TextStyle(color: CResources.grey),
      prefixIcon: const Icon(
        Icons.search,
        color: CResources.orange,
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CResources.grey.withOpacity(0.6))),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CResources.grey.withOpacity(0.2))));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextField(
        controller: editingCintroller,
        decoration: inputDecoration,
        readOnly: true,
        onTap: () {
          showSearch(context: context, delegate: SearchFoodsDeleigate());
        },
      ),
    );
  }
}
