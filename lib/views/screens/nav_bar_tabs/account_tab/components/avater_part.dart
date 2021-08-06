import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/state_management/auth_providers.dart';
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
    var authProvider = Provider.of<AuthProvider>(context);
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
              backgroundColor: CResources.orange,
              onPressed: () async {},
              child: const Icon(Icons.add),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(
                  authProvider.currentUser?.photoURL ?? Images.avaterImageLink),
              backgroundColor: CResources.blueGrey.withOpacity(0.4),
              radius: 50,
            ),
            FloatingActionButton(
              mini: true,
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logOut();
              },
              backgroundColor: CResources.orange,
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
              color: CResources.blueGrey,
              fontFamily: Strings.notosansFontFamilly),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Seen Braxson Street Cortland, It 600112',
          style: TextStyle(
              color: CResources.grey, fontFamily: Strings.notosansFontFamilly),
        )
      ],
    );
  }
}
