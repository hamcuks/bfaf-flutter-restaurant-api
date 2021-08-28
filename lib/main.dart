import 'package:dicoding_submission_restaurant_app_api/theme.dart';
import 'package:dicoding_submission_restaurant_app_api/ui/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restauranku',
      theme: ThemeData(scaffoldBackgroundColor: MyTheme.scaffoldBackground),
      home: HomePage(),
    );
  }
}
