import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/di_containers.dart';
import 'package:food_delivery/state_management/auth_providers.dart';
import 'package:food_delivery/utils/repos/firestore_repo.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:provider/provider.dart';

class AvaterPart extends StatefulWidget {
  const AvaterPart({Key? key}) : super(key: key);

  @override
  State<AvaterPart> createState() => _AvaterPartState();
}

class _AvaterPartState extends State<AvaterPart> {
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
              backgroundColor: ColorResources.orange,
              onPressed: () async {},
              child: const Icon(Icons.add),
            ),
            CircleAvatar(
              backgroundImage: const NetworkImage(Images.avaterImageLink),
              radius: 50,
              child: Center(child: Image.asset(Images.avaterImageLogo)),
            ),
            FloatingActionButton(
              mini: true,
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logOut();
              },
              backgroundColor: ColorResources.orange,
              child: const Icon(Icons.exit_to_app),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Istiak Ahmed',
          style: TextStyle(
              fontSize: 25,
              color: ColorResources.blueGrey,
              fontFamily: Strings.notosansFontFamilly),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Seen Braxson Street Cortland, It 600112',
          style: TextStyle(
              color: ColorResources.grey,
              fontFamily: Strings.notosansFontFamilly),
        )
      ],
    );
  }
}
