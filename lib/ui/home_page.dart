import 'package:dicoding_submission_restaurant_app_api/model/detail_arguments_model.dart';
import 'package:dicoding_submission_restaurant_app_api/model/detail_restaurant_model.dart';
import 'package:dicoding_submission_restaurant_app_api/model/list_restaurant_model.dart';
import 'package:dicoding_submission_restaurant_app_api/network/api_service.dart';
import 'package:dicoding_submission_restaurant_app_api/provider/restaurant_provider.dart';
import 'package:dicoding_submission_restaurant_app_api/theme.dart';
import 'package:dicoding_submission_restaurant_app_api/widget/info_restaurant_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 24,
            left: 22,
            right: 22,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _homeHeader(),
              SizedBox(
                height: 22,
              ),
              Material(
                borderRadius: BorderRadius.circular(8),
                elevation: 8,
                shadowColor: Colors.black26,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Warmindo dekat sini..',
                    suffixIcon: Icon(
                      Icons.search,
                      color: MyTheme.green,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Expanded(
                child: RestoranWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column _homeHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, Dicoding,',
          style: MyTheme.normalText.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          'Welcome back!',
          style: MyTheme.largeText,
        ),
        SizedBox(
          height: 22,
        ),
        Text(
          'Mau makan apa hari ini? Yuk cari restoran terdekatmu!',
          style: MyTheme.normalText,
        ),
      ],
    );
  }
}

class RestoranWidget extends StatelessWidget {
  const RestoranWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Restoran',
          style: MyTheme.largeText,
        ),
        SizedBox(
          height: 8,
        ),
        ChangeNotifierProvider<RestaurantProvider>(
          lazy: true,
          create: (_) => RestaurantProvider(apiService: ApiService()),
          child: Expanded(
            flex: 10,
            child: Consumer<RestaurantProvider>(
              builder: (context, data, _) {
                if (data.state == ResultState.LOADING) {
                  print(data.state);
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.state == ResultState.HAS_DATA) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => _buildRestaurantCard(
                      context: context,
                      data: data.listRestaurantResult!.restaurants![index],
                    ),
                    itemCount: data.listRestaurantResult!.restaurants!.length,
                  );
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
      ],
    );
  }

  InkWell _buildRestaurantCard({BuildContext? context, data}) {
    return InkWell(
      onTap: () => Navigator.of(context!).pushNamed(
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
