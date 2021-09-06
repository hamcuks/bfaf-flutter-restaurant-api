import 'package:dicoding_submission_restaurant_app_api/theme.dart';
import 'package:flutter/material.dart';

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
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => Card(
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('123'),
                    ),
                  ),
                  itemCount: 5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
