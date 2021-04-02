import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
/**
 * 封装SharedPreferences本地存储
 * https://pub.dev/packages/shared_preferences/
 */
class AppStorage {

  /// singleton design mode.
  static AppStorage _instance = new AppStorage._();
  factory AppStorage() => _instance;
  static SharedPreferences _prefs;

  AppStorage._();

  /// init sharedpreferences
  static Future<void> init() async {
    if(_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  /// serialization object save json.
  Future<bool> setJSON(String key, dynamic jsonVal) {
    String jsonStr = jsonEncode(jsonVal);
    return _prefs.setString(key, jsonStr);
  }

  /// serialization json parse object.
  dynamic getJSON(String key) {
    String jsonStr = _prefs.getString(key);
    return jsonStr == null ? null : jsonDecode(jsonStr);
  }

  Future<bool> setBool(String key, bool val){
    return _prefs.setBool(key, val);
  }

  bool getBool(String key) {
    bool val = _prefs.getBool(key);
    return val == null ? false : val;
  }

  /// remove information from storage.
  Future<bool> remove(String key){
    return _prefs.remove(key);
  }

  /// set string list
  Future<bool> setStringList(String key, List<String> content) {
    return _prefs.setStringList(key, content);
  }

  /// get string list
  List<String> getStringList(String key) {
    return _prefs.getStringList(key);
  }

}