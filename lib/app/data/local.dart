import 'package:quick_stay_flutter/app/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final LocalStorage _localStorage = LocalStorage._internal();

  SharedPreferences prefs;

  factory LocalStorage(SharedPreferences preferences) {
    _localStorage.prefs = preferences;
    return _localStorage;
  }

  LocalStorage._internal();

  setDarkMode(bool value) {
    prefs.setBool(AppPresKey.useDarkMode, value);
  }

  getIsDarkMode(String key) {
    bool value = prefs.getBool(key) ?? false;
    return value;
  }
}
