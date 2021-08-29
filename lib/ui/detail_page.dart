import 'package:dicoding_submission_restaurant_app_api/model/detail_arguments_model.dart';
import 'package:dicoding_submission_restaurant_app_api/model/detail_restaurant_model.dart';
import 'package:dicoding_submission_restaurant_app_api/network/api_service.dart';
import 'package:dicoding_submission_restaurant_app_api/provider/detail_restaurant_provider.dart';
import 'package:dicoding_submission_restaurant_app_api/widget/info_restaurant_widget.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => ApiService().detailRestaurant(data.id),
      ),
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
            create: (_) =>
                DetailRestaurantProvider(apiService: ApiService(), id: data.id),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
              child: Consumer<DetailRestaurantProvider>(
                builder: (context, data, _) {
                  if (data.state == ResultState.LOADING) {
                    print(data.state);
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.state == ResultState.HAS_DATA) {
                    print("STATE: ${data.state}");
                    return _buildDetailRestaurant(
                        data.detailRestaurantResult!.restaurant);
                  } else if (data.state == ResultState.NO_DATA) {
                    return Center(
                      child: Text('${data.message}'),
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
        Container(
          width: double.infinity,
          height: 200,
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
                  text: "${data.city}",
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
