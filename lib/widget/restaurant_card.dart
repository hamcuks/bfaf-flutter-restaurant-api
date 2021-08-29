import 'package:dicoding_submission_restaurant_app_api/model/detail_arguments_model.dart';
import 'package:dicoding_submission_restaurant_app_api/widget/info_restaurant_widget.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({Key? key, this.data}) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        '/detail',
        arguments: DetailArguments(
          id: data.id,
          name: data.name,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 8, offset: Offset(1, 2)),
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
                Text(
                  '${data.name}',
                  style: MyTheme.normalText,
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
            )
          ],
        ),
      ),
    );
  }
}
