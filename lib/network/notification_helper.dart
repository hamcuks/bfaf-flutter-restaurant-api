import 'dart:convert';

import 'package:dicoding_submission_restaurant_app_api/model/list_restaurant_model.dart';
import 'package:dicoding_submission_restaurant_app_api/navigation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var _initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var _initializationSettings =
        InitializationSettings(android: _initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(_initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) print('Notif payload: $payload');

      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      ListRestaurantModel? restaurant) async {
    String _channelId = '1';
    String _channelName = 'channel_01';
    String _channelDescription = 'BFAF Dicoding Submission';

    var androidPlatformSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: DefaultStyleInformation(true, true),
    );

    var platformSpecifics =
        NotificationDetails(android: androidPlatformSpecifics);

    var titleNotification = "<b>Rekomendasi Restoran hari ini!</b>";
    var titleRestaurant = restaurant!.restaurants![0].name;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titleRestaurant,
      platformSpecifics,
      payload: json.encode(
        restaurant.toJson(),
      ),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((String payload) async {
      var data = ListRestaurantModel.fromJson(json.decode(payload));
      var restaurant = data.restaurants![0];
      Navigation.intentWithData(routeName: route, args: restaurant);
    });
  }
}
