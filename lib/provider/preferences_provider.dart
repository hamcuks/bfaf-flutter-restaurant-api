import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:dicoding_submission_restaurant_app_api/helper/background_service.dart';
import 'package:dicoding_submission_restaurant_app_api/helper/date_time_helper.dart';
import 'package:dicoding_submission_restaurant_app_api/network/preferences_helper.dart';
import 'package:flutter/foundation.dart';

class PreferencesProvider extends ChangeNotifier {
  final PreferencesHelper _prefHelper = PreferencesHelper();

  PreferencesProvider() {
    _getPreferences();
  }

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  bool _isReminderActive = false;
  bool get isReminderActive => _isReminderActive;

  void _getPreferences() async {
    _isDarkMode = await _prefHelper.isDarkMode;
    _isReminderActive = await _prefHelper.isDailyReminder;
    notifyListeners();
  }

  set isDarkMode(bool value) {
    _isDarkMode = value;
    _prefHelper.setDarkMode(value);
    notifyListeners();
  }

  set isReminderActive(bool value) {
    _isReminderActive = value;
    _prefHelper.setDailyReminder(value);
    notifyListeners();
    dailyReminderRestaurant();
  }

  Future<void> dailyReminderRestaurant() async {
    if (_isReminderActive) {
      print('reminder aktif');
      notifyListeners();
      await AndroidAlarmManager.periodic(
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
      await AndroidAlarmManager.cancel(1);
    }
  }
}
