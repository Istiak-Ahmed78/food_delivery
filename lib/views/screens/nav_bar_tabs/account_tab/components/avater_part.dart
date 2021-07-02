import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/views/styles/colors.dart';

class AvaterPart extends StatelessWidget {
  const AvaterPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            FloatingActionButton(
              mini: true,
              backgroundColor: kOrange,
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
            const CircleAvatar(
              backgroundImage: NetworkImage(avaterImageLink),
              radius: 50,
            ),
            FloatingActionButton(
              mini: true,
              onPressed: () {},
              backgroundColor: kOrange,
              child: const Icon(Icons.message),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Istiak Ahmed',
          style:
              TextStyle(fontSize: 25, color: kBlueGrey, fontFamily: kNotosans),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Seen Braxson Street Cortland, It 600112',
          style: TextStyle(color: kGrey, fontFamily: kNotosans),
        )
      ],
    );
  }
}
