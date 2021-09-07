import 'package:dicoding_submission_restaurant_app_api/model/detail_arguments_model.dart';
import 'package:dicoding_submission_restaurant_app_api/model/favourite_model.dart';
import 'package:dicoding_submission_restaurant_app_api/provider/detail_restaurant_provider.dart';
import 'package:dicoding_submission_restaurant_app_api/provider/favourite_provider.dart';
import 'package:dicoding_submission_restaurant_app_api/provider/result_state.dart';
import 'package:dicoding_submission_restaurant_app_api/widget/info_restaurant_widget.dart';
import 'package:dicoding_submission_restaurant_app_api/widget/load_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  final DetailArguments data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${data.name}',
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black87,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ChangeNotifierProvider<DetailRestaurantProvider>(
            create: (_) => DetailRestaurantProvider(id: data.id),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
              child: Consumer<DetailRestaurantProvider>(
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
                    return _buildDetailRestaurant(
                        data.detailRestaurantResult!.restaurant);
                  } else if (data.state == ResultState.NO_DATA) {
                    return LoadAnimation(
                      fileName: 'not-found',
                      text: 'Tidak Dapat Menemukan Data...',
                      width: 250,
                    );
                  } else if (data.state == ResultState.NO_INTERNET) {
                    return LoadAnimation(
                      fileName: 'no-internet',
                      text:
                          'Tidak dapat memuat data, pastikan anda terkoneksi internet...',
                      width: 250,
                    );
                  } else {
                    return Center(
                      child: Text(''),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildDetailRestaurant(final data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              margin: EdgeInsets.only(bottom: 27),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://restaurant-api.dicoding.dev/images/large/${data.pictureId}'),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 10,
              child: Consumer<FavouriteProvider>(
                builder: (context, provider, _) {
                  return FutureBuilder<bool>(
                      future: provider.isFavourite(data.id),
                      builder: (context, snapshot) {
                        var isFavourite = snapshot.data ?? false;
                        return Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          child: IconButton(
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
                        );
                      });
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 28,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deskripsi Restoran',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "${data.description}",
              style: TextStyle(fontSize: 16, height: 1.5),
              maxLines: 6,
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                InfoRestaurant(
                  icon: Icons.star,
                  iconColor: Colors.orange,
                  text: "${data.rating}",
                ),
                SizedBox(
                  width: 22,
                ),
                InfoRestaurant(
                  icon: Icons.location_pin,
                  iconColor: Colors.red,
                  text: "${data.address}, ${data.city}",
                ),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Makanan (${data.menus.foods.length})',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 16,
                ),
                for (var item in data.menus.foods)
                  _buildFoodAndDrinkItem(
                      icon: Icons.ramen_dining_outlined, text: item.name),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Minuman (${data.menus.drinks.length})',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 16,
                ),
                for (var item in data.menus.drinks)
                  _buildFoodAndDrinkItem(
                      icon: Icons.local_cafe, text: item.name),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ulasan (${data.customerReviews.length})',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 16,
                ),
                for (var item in data.customerReviews)
                  _buildUlasanItem(data: item)
              ],
            )
          ],
        )
      ],
    );
  }

  Container _buildFoodAndDrinkItem({IconData? icon, String? text}) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      height: 50,
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(
            width: 16,
          ),
          Text(
            "$text",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Container _buildUlasanItem({data}) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            data.review,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, height: 1.4),
          ),
          SizedBox(
            height: 8,
          ),
          Text(data.date),
        ],
      ),
    );
  }
}
