import 'package:dicoding_submission_restaurant_app_api/network/database_helper.dart';
import 'package:dicoding_submission_restaurant_app_api/model/detail_restaurant_model.dart';
import 'package:dicoding_submission_restaurant_app_api/model/favourite_model.dart';
import 'package:dicoding_submission_restaurant_app_api/provider/favourite_provider.dart';
import 'package:dicoding_submission_restaurant_app_api/provider/result_state.dart';
import 'package:dicoding_submission_restaurant_app_api/theme.dart';
import 'package:dicoding_submission_restaurant_app_api/widget/load_animation_widget.dart';
import 'package:dicoding_submission_restaurant_app_api/widget/restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Favoritmu',
                style: MyTheme.largeText,
              ),
              SizedBox(
                height: 22,
              ),
              ChangeNotifierProvider<FavouriteProvider>(
                create: (_) => FavouriteProvider(),
                child: Consumer<FavouriteProvider>(
                  builder: (context, data, _) {
                    if (data.state == ResultState.LOADING) {
                      print(data.state);
                      return LoadAnimation(
                        fileName: 'loading',
                        text: 'Sedang Memuat Data...',
                        width: 50,
                      );
                    } else if (data.state == ResultState.HAS_DATA) {
                      print("STATE: ${data.state}");
                      return Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) => RestaurantCard(
                            data: data.favouriteResult[index],
                          ),
                          itemCount: data.favouriteResult.length,
                        ),
                      );
                    } else if (data.state == ResultState.NO_DATA) {
                      return Expanded(
                        child: LoadAnimation(
                          fileName: 'not-found',
                          text: 'Favorite (0)',
                          width: 250,
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(''),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
