import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final SharedPreferencesHelper _instance =
      SharedPreferencesHelper._internal();
  SharedPreferences? _preferences;

  factory SharedPreferencesHelper() {
    return _instance;
  }

  SharedPreferencesHelper._internal();

  Future<void> init() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
  }

  Future<void> setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  String? getString(String key) {
    return _preferences?.getString(key);
  }
}
