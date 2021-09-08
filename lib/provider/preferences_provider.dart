import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:dicoding_submission_restaurant_app_api/helper/background_service.dart';
import 'package:dicoding_submission_restaurant_app_api/helper/date_time_helper.dart';
import 'package:dicoding_submission_restaurant_app_api/network/preferences_helper.dart';
import 'package:flutter/foundation.dart';

class PreferencesProvider extends ChangeNotifier {
  final PreferencesHelper _prefHelper = PreferencesHelper();

  PreferencesProvider() {
    _getTheme();
  }

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void _getTheme() async {
    _isDarkMode = await _prefHelper.isDarkMode;
    notifyListeners();
  }

  set isDarkMode(bool value) {
    _isDarkMode = value;
    _prefHelper.darkMode(value);
    notifyListeners();
  }

  bool _isReminderActive = false;
  bool get isReminderActive => _isReminderActive;

  Future<bool> dailyReminderRestaurant(bool val) async {
    _isReminderActive = val;
    if (_isReminderActive) {
      print('reminder aktif');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('reminder disabled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
