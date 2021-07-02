import 'package:flutter/material.dart';
import 'package:food_delivery/views/shared_widgets/appbar.dart';
import 'package:food_delivery/views/shared_widgets/expension.dart';
import 'package:food_delivery/views/styles/colors.dart';

import '../../../../constants.dart';
import 'components/componets.dart';
import 'components/section_title.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(title: 'Profile'),
      drawer: Drawer(),
      body: Padding(
        padding: const EdgeInsets.only(
            left: 10, right: 10, bottom: kToolbarHeight + 10),
        child: ListView(
          shrinkWrap: true,
          children: [
            const AvaterPart(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: SectionTitle(
                title: 'About',
                icon: Icons.person,
              ),
            ),
            Text(
              dummyText,
              style: TextStyle(color: kBlueGrey.withOpacity(0.7)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: SectionTitle(
                  title: 'Recent Orders', icon: Icons.shopping_bag),
            ),
            ExpensionList()
          ],
        ),
      ),
    );
  }
}
