import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) async {
    return await sharedPreferences!.setString(key, value);
  }

  static getString(key) {
    return sharedPreferences!.getString(key);
  }

  static removeString(key) {
    return sharedPreferences!..remove(key);
  }
}
