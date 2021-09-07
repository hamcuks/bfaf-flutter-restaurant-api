import 'package:dicoding_submission_restaurant_app_api/model/detail_arguments_model.dart';
import 'package:dicoding_submission_restaurant_app_api/network/api_service.dart';
import 'package:dicoding_submission_restaurant_app_api/provider/favourite_provider.dart';
import 'package:dicoding_submission_restaurant_app_api/provider/preferences_provider.dart';
import 'package:dicoding_submission_restaurant_app_api/provider/restaurant_provider.dart';
import 'package:dicoding_submission_restaurant_app_api/theme.dart';
import 'package:dicoding_submission_restaurant_app_api/ui/detail_page.dart';
import 'package:dicoding_submission_restaurant_app_api/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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
