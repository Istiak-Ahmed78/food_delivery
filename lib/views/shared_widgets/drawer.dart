import 'package:flutter/material.dart';
import 'package:food_delivery/state_management/tab_index.dart';
import 'package:food_delivery/views/screens/settings_page/settings_screen.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

class DefaultDrawer extends StatelessWidget {
  const DefaultDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Row(
              children: [
                Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(Images.avaterImageLink)))),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Istiak Ahmed',
                      style: TextStyle(
                          color: ColorResources.blueGrey,
                          fontFamily: Strings.notosansFontFamilly,
                          fontSize: 20),
                    ),
                    Text(
                      'aistiak6@gail.com',
                      style: TextStyle(
                          color: ColorResources.blueGrey,
                          fontFamily: Strings.notosansFontFamilly),
                    )
                  ],
                )
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Provider.of<TabIndex>(context, listen: false).setIndex(3);
              Navigator.pop(context);
            },
            title: const Text('Favorites'),
            leading: const Icon(Icons.favorite),
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
            leading: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
