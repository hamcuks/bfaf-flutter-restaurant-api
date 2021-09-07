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

    //_getTheme();
  }
}
