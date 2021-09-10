import 'dart:convert';
import 'dart:math';

import 'package:dicoding_submission_restaurant_app_api/model/detail_arguments_model.dart';
import 'package:dicoding_submission_restaurant_app_api/model/list_restaurant_model.dart';
import 'package:dicoding_submission_restaurant_app_api/navigation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;
  int randomNumber = Random()
      .nextInt(20); // generate random number from 0 - 20 (restaurant count)

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    var _initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var _initializationSettings =
        InitializationSettings(android: _initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(_initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) print('Notif payload: $payload');

      selectNotificationSubject.add(payload ?? "no data");
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

    var randomRestaurant = restaurant!.restaurants![randomNumber];
    var titleNotification = "<b>Rekomendasi Restoran hari ini! 😋</b>";
    var titleRestaurant = randomRestaurant.name;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titleRestaurant,
      platformSpecifics,
      payload: json.encode({
        "id": randomRestaurant.id,
        "name": randomRestaurant.name,
      }),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.listen((value) {
      var data = json.decode(value);

      Navigation.intentWithData(
          routeName: '/detail',
          args: DetailArguments(id: data["id"], name: data["name"]));

      print("GO TO DETAILL");
    });
  }
}
