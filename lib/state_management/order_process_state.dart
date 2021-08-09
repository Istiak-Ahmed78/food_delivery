import 'package:flutter/cupertino.dart';
import 'package:food_delivery/di_containers.dart';
import 'package:food_delivery/models/order_information_model.dart';
import 'package:food_delivery/models/ordered_info_model.dart';
import 'package:food_delivery/state_management/cart_list_state.dart';
import 'package:food_delivery/utils/repos/auth_repo.dart';
import 'package:food_delivery/utils/repos/firestore_repo.dart';
import 'package:provider/provider.dart';

class OrderProcessState extends ChangeNotifier {
  OrderInformationModel? orderInformationModelLocal;

  Future<void> compleOrderingProccess(BuildContext context) async {
    if (orderInformationModelLocal != null) {
      String orderId = DateTime.now().toString().trim();
      String? userId = services<AuthRepos>().userId;
      var dataToSet = Provider.of<CartListState>(context, listen: false)
          .globalCheckedOutList;

      await services<FirestoreRepos>().addOrdedList(userId, orderId, dataToSet);

      await services<FirestoreRepos>().setOrderDetails(
          userId,
          orderId,
          OrderedInfoModel(
            orderId: orderId,
            orderState: 0,
          ));
      await Provider.of<CartListState>(context, listen: false)
          .deleteShoppingCartListItems(userId);
    } else {
      print('OrderInformation is emty');
    }
  }
}
