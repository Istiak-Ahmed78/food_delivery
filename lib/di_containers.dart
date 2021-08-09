import 'package:food_delivery/state_management/auth_providers.dart';
import 'package:food_delivery/state_management/tab_index.dart';
import 'package:food_delivery/utils/repos/auth_repo.dart';
import 'package:food_delivery/utils/shared_prefer.dart';
import 'package:get_it/get_it.dart';
import 'state_management/cart_list_state.dart';
import 'state_management/favorite_list_state.dart';
import 'state_management/order_process_state.dart';
import 'utils/repos/firestore_repo.dart';

final services = GetIt.I;

void init() {
  //Repos
  services.registerLazySingleton<AuthRepos>(() => AuthRepos());
  services.registerLazySingleton<FirestoreRepos>(() => FirestoreRepos());

  //Providers
  services.registerLazySingleton(() => TabIndex());
  services.registerLazySingleton(() => SharedPreProvider());
  services.registerLazySingleton(() => FavoriteFoodItems());
  services.registerLazySingleton(() => CartListState());
  services.registerLazySingleton(() => OrderProcessState());
  services.registerLazySingleton<AuthProvider>(
      () => AuthProvider(authRepos: services()));
}
