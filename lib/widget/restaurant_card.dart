import 'package:dicoding_submission_restaurant_app_api/model/detail_arguments_model.dart';
import 'package:dicoding_submission_restaurant_app_api/model/favourite_model.dart';
import 'package:dicoding_submission_restaurant_app_api/navigation.dart';
import 'package:dicoding_submission_restaurant_app_api/provider/favourite_provider.dart';
import 'package:dicoding_submission_restaurant_app_api/widget/info_restaurant_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class RestaurantCard extends StatelessWidget {
  RestaurantCard({Key? key, this.data}) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigation.intentWithData(
        routeName: '/detail',
        args: DetailArguments(
          id: data.id,
          name: data.name,
        ),
      ),
      child: Consumer<FavouriteProvider>(
        builder: (context, provider, _) {
          return FutureBuilder(
              future: provider.isFavourite(data.id),
              builder: (context, snapshot) {
                var isFavourite = snapshot.data ?? false;
                return Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(1, 2)),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black87,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                'https://restaurant-api.dicoding.dev/images/small/${data.pictureId}'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 180,
                            child: Text(
                              '${data.name}',
                              style: MyTheme.normalText,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              InfoRestaurant(
                                icon: Icons.star,
                                iconColor: Colors.orange,
                                text: '${data.rating}',
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              InfoRestaurant(
                                icon: Icons.location_pin,
                                iconColor: Colors.red,
                                text: '${data.city}',
                              ),
                            ],
                          )
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          if (isFavourite as bool) {
                            provider.removeFavourite(data.id);
                          } else {
                            provider.addToFavourite(
                              FavouriteModel(
                                id: '${data.id}',
                                name: '${data.name}',
                                city: '${data.city}',
                                rating: '${data.rating}',
                                pictureId: '${data.pictureId}',
                              ),
                            );
                          }
                        },
                        icon: isFavourite as bool
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(Icons.favorite_outline),
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
