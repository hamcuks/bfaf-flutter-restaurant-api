import 'package:dicoding_submission_restaurant_app_api/model/detail_arguments_model.dart';
import 'package:flutter/cupertino.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intentWithData({String? routeName, DetailArguments? args}) {
    navigatorKey.currentState?.pushNamed(routeName!, arguments: args!);
  }

  static back() => navigatorKey.currentState?.pop();
}
