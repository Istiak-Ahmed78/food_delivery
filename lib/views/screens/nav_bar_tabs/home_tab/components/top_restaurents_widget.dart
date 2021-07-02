import 'package:flutter/material.dart';
import 'package:food_delivery/models/restaurant_model.dart';
import 'package:food_delivery/views/screens/nav_bar_tabs/home_tab/components/components.dart';
import 'package:food_delivery/views/shared_widgets/headline.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:food_delivery/views/styles/paddings.dart';

class TopRestaurentsWiget extends StatelessWidget {
  const TopRestaurentsWiget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: _size.height * 0.45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const HeadLine(
            title: 'Top Restaurents',
            subTitle: 'Ordered by Nearby first',
            iconData: Icons.stars,
          ),
          SizedBox(
            height: _size.height * 0.02,
          ),
          Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: RestaurentListItemModel.topRestaurentList.length,
                  itemBuilder: (context, index) => TopRestauarentListItem(
                        restaurentListItemModel:
                            RestaurentListItemModel.topRestaurentList[index],
                      )))
        ],
      ),
    );
  }
}

class TopRestauarentListItem extends StatelessWidget {
  final RestaurentListItemModel restaurentListItemModel;
  const TopRestauarentListItem(
      {Key? key, required this.restaurentListItemModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(right: kPadding30),
      child: Card(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: Container(
            height: _size.height * 0.34,
            width: _size.width * 0.84,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                restaurentListItemModel.imageAdress),
                            fit: BoxFit.cover)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(kPadding10),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                restaurentListItemModel.title,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: kBlueGrey),
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                maxLines: 1,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                restaurentListItemModel.subTitle,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                style: TextStyle(color: kGrey.withOpacity(0.7)),
                                softWrap: false,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Ratting(ratting: restaurentListItemModel.rating)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 50,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: const BoxDecoration(
                            color: kOrangeAccent,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        alignment: Alignment.center,
                        child: const Icon(Icons.directions),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
