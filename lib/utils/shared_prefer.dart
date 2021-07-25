import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class SharedPreProvider extends ChangeNotifier {
  bool isFirstLauchLocal = false;
  bool get isFirstLaunch => isFirstLauchLocal;

  void setIntroBoolTrue() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(Sectrets.isFirstLaunchKey, false);
    isFirstLauchLocal = false;
    notifyListeners();
  }

  Future<void> getIntroBool() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool value = sharedPreferences.getBool(Sectrets.isFirstLaunchKey) ?? false;
    if (value) {
      isFirstLauchLocal = value;
      notifyListeners();
    }
  }
}
