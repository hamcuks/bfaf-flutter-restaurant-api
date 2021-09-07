import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences as Future<SharedPreferences>;

  static const DARK_MODE = 'DARK_MODE';

  Future<bool> get isDarkMode async {
    final prefs = await _sharedPreferences;
    return prefs.getBool(DARK_MODE) ?? false;
  }

  void darkMode(bool value) async {
    final prefs = await _sharedPreferences;
    prefs.setBool(DARK_MODE, value);
  }
}
