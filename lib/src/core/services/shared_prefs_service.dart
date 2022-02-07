import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService{
  late SharedPreferences _preferences;

  Future<void> init() async {
    _preferences =  await SharedPreferences.getInstance();
  }

  int? getInt(String key) => _preferences.getInt(key);
  Future<void> setInt(String key, int value) => _preferences.setInt(key, value);
}