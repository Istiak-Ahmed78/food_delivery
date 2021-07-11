import 'package:food_delivery/models/restaurant_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderModel {
  final DateTime? orderTime;
  final RestaurentListItemModel restaurentListItemModel;
  OrderModel({this.orderTime, required this.restaurentListItemModel});
  static List<OrderModel> orderModelList = [
    OrderModel(
        restaurentListItemModel: RestaurentListItemModel(
            title: 'Home cooking Expertice',
            subTitle:
                'Letraset sheets containing Language hfhha nfjngs snkjgn ',
            rating: 5,
            price: 10.0,
            position: const LatLng(22.3657, 91.7782),
            imageAdress:
                'https://lp-cms-production.imgix.net/image_browser/Ithaa-Maldives.jpg?auto=format&fit=crop&sharp=10&vib=20&ixlib=react-8.6.4&w=850&q=75&dpr=1'),
        orderTime: DateTime.now())
  ];
}
