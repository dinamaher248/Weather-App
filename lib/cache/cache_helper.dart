

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences; 

  //! Here The Initialize of cache.
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  //! Method to get a string value by key
  static String? getDataString({required String key}) {
    if (sharedPreferences == null) return null; 
    return sharedPreferences!.getString(key);
  }

  //! Method to save data
  static Future<bool> saveData({required String key, required dynamic value}) async {
    if (sharedPreferences == null) return false; 
    if (value is bool) {
      return await sharedPreferences!.setBool(key, value);
    }

    if (value is String) {
      return await sharedPreferences!.setString(key, value);
    }

    if (value is int) {
      return await sharedPreferences!.setInt(key, value);
    } else {
      return await sharedPreferences!.setDouble(key, value);
    }
  }

  //! Method to get data already saved in local database
  static dynamic getData({required String key}) {
    if (sharedPreferences == null) return null; 
    return sharedPreferences!.get(key);
  }

  //! Remove data using specific key
  static Future<bool> removeData({required String key}) async {
    if (sharedPreferences == null) return false; 
    return await sharedPreferences!.remove(key);
  }

  //! Method to check if local database contains {key}
  static Future<bool> containsKey({required String key}) async {
    if (sharedPreferences == null) return false; 
    return sharedPreferences!.containsKey(key);
  }

  //! Method to clear all data in local database
  static Future<bool> clearData() async {
    if (sharedPreferences == null) return false;
    return await sharedPreferences!.clear();
  }

  //! Method to put data in local database using key
  static Future<bool> put({
    required String key,
    required dynamic value,
  }) async {
    if (sharedPreferences == null) return false; 
    if (value is String) {
      return await sharedPreferences!.setString(key, value);
    } else if (value is bool) {
      return await sharedPreferences!.setBool(key, value);
    } else {
      return await sharedPreferences!.setInt(key, value);
    }
  }
}
