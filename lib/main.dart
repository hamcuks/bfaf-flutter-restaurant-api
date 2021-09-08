import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:dicoding_submission_restaurant_app_api/helper/background_service.dart';
import 'package:dicoding_submission_restaurant_app_api/model/detail_arguments_model.dart';
import 'package:dicoding_submission_restaurant_app_api/navigation.dart';
import 'package:dicoding_submission_restaurant_app_api/network/api_service.dart';
import 'package:dicoding_submission_restaurant_app_api/network/notification_helper.dart';
import 'package:dicoding_submission_restaurant_app_api/provider/favourite_provider.dart';
import 'package:dicoding_submission_restaurant_app_api/provider/preferences_provider.dart';
import 'package:dicoding_submission_restaurant_app_api/provider/restaurant_provider.dart';
import 'package:dicoding_submission_restaurant_app_api/theme.dart';
import 'package:dicoding_submission_restaurant_app_api/ui/detail_page.dart';
import 'package:dicoding_submission_restaurant_app_api/ui/home_page.dart';
import 'package:dicoding_submission_restaurant_app_api/ui/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();
  await AndroidAlarmManager.initialize();
  await _notificationHelper.initNotification(flutterLocalNotificationsPlugin);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => FavouriteProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(),
          child: SettingsPage(),
        )
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, data, _) => MaterialApp(
          title: 'Restauranku',
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: MyTheme.scaffoldBackground,
            cardColor: Colors.white,
          ),
          darkTheme: ThemeData.dark().copyWith(
            cardColor: Color(0xFF434343),
          ),
          themeMode: data.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          navigatorKey: navigatorKey,
          initialRoute: '/',
          routes: {
            '/': (context) => HomePage(),
            '/detail': (context) => DetailPage(
                data: ModalRoute.of(context)?.settings.arguments
                    as DetailArguments),
          },
        ),
      ),
    );
  }
}
