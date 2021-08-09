import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderedInfoModel {
  final String orderId;
  final int orderState;
  final String? orderDeleveryLatLong;

  OrderedInfoModel(
      {required this.orderId,
      required this.orderState,
      this.orderDeleveryLatLong});

  static Map<String, dynamic> toMap(OrderedInfoModel orderedInfoModel) {
    return {
      'Order Id': orderedInfoModel.orderId,
      'Order state': orderedInfoModel.orderState,
      'LatLog': orderedInfoModel.orderDeleveryLatLong ??
          const LatLng(0.0, 0.0).toString()
    };
  }

  factory OrderedInfoModel.fromMap(Map<String, dynamic> mappedData) {
    return OrderedInfoModel(
        orderId: mappedData['Product Id'] ?? '1',
        orderState: mappedData['Order state'],
        orderDeleveryLatLong:
            mappedData['Order state'] == 2 ? mappedData['LatLog'] : null);
  }
}

//TODO: Implement it
String getOrderState(int takeInt) {
  if (takeInt == 0) {
    return 'Proccessing';
  } else if (takeInt == 1) {
    return 'In the kitchen';
  } else if (takeInt == 2) {
    return 'On the way';
  } else if (takeInt == 3) {
    return 'Delivered';
  } else if (takeInt == 4) {
    return 'Cancelled';
  } else {
    return 'Oeder is not completed';
  }
}
