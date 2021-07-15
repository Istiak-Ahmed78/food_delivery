import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class SharedPre {
  void setIntroBoolTrue() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(isFirstLaunchKey, true);
  }

  Future<bool?> getIntroBool() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(isFirstLaunchKey);
  }
}