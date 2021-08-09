import 'package:flutter/material.dart';
import 'package:food_delivery/views/styles/colors.dart';

class Ratting extends StatelessWidget {
  const Ratting({Key? key, required this.ratting}) : super(key: key);
  final int ratting;

  List<Widget> rattingStatrs(int totalRating) {
    var rattinIconList = List<Widget>.generate(
        totalRating,
        (_) => const Icon(
              Icons.star,
              size: 17,
              color: CResources.orangeAccent,
            ));
    var nonRatedStarsList = List.generate(
        5 - rattinIconList.length,
        (_) => const Icon(
              Icons.star_border_outlined,
              size: 17,
              color: CResources.orangeAccent,
            ));
    return List.from(rattinIconList)..addAll(nonRatedStarsList);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [for (final r in rattingStatrs(ratting)) r],
    );
  }
}
