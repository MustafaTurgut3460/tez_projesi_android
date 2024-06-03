import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("apposite-token", token);
  }

  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("apposite-token");
  }

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("apposite-token");

    return token ?? "";
  }

  static Future<void> saveData(String key, String data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }

  static Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}