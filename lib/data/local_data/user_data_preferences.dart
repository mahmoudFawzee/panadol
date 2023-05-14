// ignore_for_file: depend_on_referenced_packages

import 'package:shared_preferences/shared_preferences.dart';

class UserDataPreferences {

  static Future<bool> setUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('userId', userId);
  }

  static Future<bool> setUserCategory(String category) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString('category', category);
  }

  static Future<bool> removeUserDataPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    bool idRemoved = await prefs.remove('userId');
    bool categoryRemoved = await prefs.remove('category');
    return idRemoved && categoryRemoved;
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  Future<String?> getUserCategory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('category');
  }
}
