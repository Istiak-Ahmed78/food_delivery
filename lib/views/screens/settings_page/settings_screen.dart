import 'package:flutter/material.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/views/shared_widgets/shared_widgets.dart';
import 'package:food_delivery/views/styles/colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: CResources.red),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: CResources.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: CResources.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: SearchFoods(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Istiak Ahmed',
                          style: TextStyle(
                              color: CResources.blueGrey,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: Strings.notosansFontFamilly),
                        ),
                        Text(
                          'aistiak6@gamil.com',
                          style: TextStyle(
                              color: CResources.grey,
                              fontFamily: Strings.notosansFontFamilly),
                        )
                      ],
                    ),
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(Images.avaterImageLink),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                color: CResources.white,
                child: Column(
                  children: const [
                    ItemHeadline(
                      leadingIcon: Icons.person,
                      title: ' Profile Settings',
                    ),
                    ItemTile(
                      leading: 'Full name',
                      trailing: 'Istiak Ahmed',
                    ),
                    ItemTile(leading: 'Email', trailing: 'aistiak6@gmail.com'),
                    ItemTile(leading: 'Phone', trailing: '+8801302143101'),
                    ItemTile(
                        leading: 'Adress', trailing: 'Hathazari, Chittagong')
                  ],
                ),
              ),
              Container(
                color: CResources.white,
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: ItemHeadline(
                          leadingIcon: Icons.credit_card,
                          title: 'Payment Settings'),
                    ),
                    ItemTile(leading: 'Default Credit Cart', trailing: '4242')
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  final String leading, trailing;

  const ItemTile({Key? key, required this.leading, required this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leading,
            style: const TextStyle(
                color: CResources.grey,
                fontFamily: Strings.notosansFontFamilly),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6),
            child: Text(
              trailing,
              style: const TextStyle(
                  color: CResources.grey,
                  fontFamily: Strings.notosansFontFamilly),
            ),
          )
        ],
      ),
    );
  }
}

class ItemHeadline extends StatelessWidget {
  final IconData leadingIcon;
  final String title;

  const ItemHeadline({Key? key, required this.leadingIcon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Icon(
              leadingIcon,
              color: CResources.grey,
            ),
          ),
          Expanded(
              child: Text(
            title,
            style: const TextStyle(
                color: CResources.grey,
                fontFamily: Strings.notosansFontFamilly,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          )),
          const Text('Edit',
              style: TextStyle(
                  color: CResources.grey,
                  fontFamily: Strings.notosansFontFamilly))
        ],
      ),
    );
  }
}
