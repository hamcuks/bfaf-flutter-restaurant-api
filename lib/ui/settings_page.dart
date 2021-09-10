import 'package:dicoding_submission_restaurant_app_api/network/preferences_helper.dart';
import 'package:dicoding_submission_restaurant_app_api/provider/preferences_provider.dart';
import 'package:dicoding_submission_restaurant_app_api/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
          child: Consumer<PreferencesProvider>(
            builder: (context, data, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Settings',
                  style: MyTheme.largeText,
                ),
                SizedBox(
                  height: 22,
                ),
                Row(
                  children: [
                    Text(
                      'Turn On Dark Theme',
                      style: MyTheme.normalText,
                    ),
                    Spacer(),
                    Switch(
                      value: data.isDarkMode,
                      onChanged: (bool value) => data.isDarkMode = value,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Enable Daily Reminder',
                      style: MyTheme.normalText,
                    ),
                    Spacer(),
                    Switch(
                      value: data.isReminderActive,
                      onChanged: (bool value) => data.isReminderActive = value,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
