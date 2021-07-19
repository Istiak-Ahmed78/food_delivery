import 'package:food_delivery/state_management/auth_providers.dart';
import 'package:food_delivery/state_management/tab_index.dart';
import 'package:food_delivery/utils/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';

import 'state_management/favorite_list_state.dart';

final services = GetIt.I;

void init() {
  //Repos
  services.registerLazySingleton<AuthRepos>(() => AuthRepos());

  //Providers
  services.registerLazySingleton<AuthProvider>(
      () => AuthProvider(authRepos: services()));
  services.registerLazySingleton(() => TabIndex());
  services.registerLazySingleton(() => FavoriteFoodItems());
}
