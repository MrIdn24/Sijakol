import 'package:shared_preferences/shared_preferences.dart';

class UserDefault {
  Future<void> saveUserDefaults(List<String> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("userModel", data);
    await prefs.setBool('isLoggedIn', true);
  }

  Future<List<String>> getUserDefaults() async {
    final prefs = await SharedPreferences.getInstance();

    // Get a string value
    List<String>? userModel = prefs.getStringList("userModel");

    return userModel ?? [""];
  }

  Future<bool> getUserDefaultsLogged() async {
    final prefs = await SharedPreferences.getInstance();

    bool? isLogged = prefs.getBool("isLoggedIn");

    return isLogged ?? false;
  }

  Future<void> doLogout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('userModel');
    await prefs.remove('isLoggedIn');
  }
}