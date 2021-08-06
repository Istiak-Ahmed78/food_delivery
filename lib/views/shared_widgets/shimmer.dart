import 'package:flutter/material.dart';
import 'package:food_delivery/views/styles/colors.dart';
import 'package:food_delivery/views/styles/paddings.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmerWidget extends StatelessWidget {
  const LoadingShimmerWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> shimmerWighets = List.generate(4, (index) => singleListItem());
    return Column(children: shimmerWighets);
  }

  Widget singleListItem() {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              shimmerWidget(
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: const BoxDecoration(
                      color: ColorResources.blueGrey,
                      borderRadius: BorderRadius.all(
                          Radius.circular(Dimentions.soSmallDinmention))),
                  margin: const EdgeInsets.only(
                      right: Dimentions.soSmallDinmention),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  shimmerWidget(
                    child: Container(
                      height: Dimentions.smallDimention,
                      width: 60,
                      color: ColorResources.grey,
                    ),
                  ),
                  shimmerWidget(
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: Dimentions.smallDimention),
                      height: Dimentions.largeDimention,
                      width: 40,
                      color: ColorResources.grey,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget shimmerWidget(
          {required Widget child, Color baseColor = ColorResources.blueGrey}) =>
      Shimmer.fromColors(
          child: child,
          baseColor: baseColor,
          highlightColor: ColorResources.white);
}
