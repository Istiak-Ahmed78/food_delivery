import 'package:flutter/material.dart';
import 'package:food_delivery/views/styles/colors.dart';

class SearchFoodsDeleigate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.close,
            color: CResources.red,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Searching');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<int> numberList = List.generate(30, (_index) => _index);
    return ListView.builder(
        itemCount: numberList.length,
        itemBuilder: (context, index) => ListTile(
              title: Text(numberList[index].toString()),
            ));
  }
}
