import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  static const DARK_MODE = 'DARK_MODE';
  static const DAILY_REMINDER = 'DAILY_REMINDER';

  Future<bool> get isDarkMode async {
    final prefs = await _sharedPreferences;
    return prefs.getBool(DARK_MODE) ?? false;
  }

  void setDarkMode(bool value) async {
    final prefs = await _sharedPreferences;
    prefs.setBool(DARK_MODE, value);
  }

  Future<bool> get isDailyReminder async {
    final prefs = await _sharedPreferences;
    return prefs.getBool(DAILY_REMINDER) ?? false;
  }

  void setDailyReminder(bool value) async {
    final prefs = await _sharedPreferences;
    prefs.setBool(DAILY_REMINDER, value);
  }
}
