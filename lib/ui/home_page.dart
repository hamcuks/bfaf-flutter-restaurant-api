import 'package:dicoding_submission_restaurant_app_api/network/api_service.dart';
import 'package:dicoding_submission_restaurant_app_api/provider/restaurant_provider.dart';
import 'package:dicoding_submission_restaurant_app_api/provider/result_state.dart';
import 'package:dicoding_submission_restaurant_app_api/theme.dart';
import 'package:dicoding_submission_restaurant_app_api/widget/load_animation_widget.dart';
import 'package:dicoding_submission_restaurant_app_api/widget/restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
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
          child: ChangeNotifierProvider<RestaurantProvider>(
            lazy: false,
            create: (_) => RestaurantProvider(apiService: ApiService()),
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
                  child: Consumer<RestaurantProvider>(
                    builder: (context, provider, _) => TextField(
                      //onTap: () => Navigator.of(context).pushNamed('/search'),
                      controller: _searchController,
                      onChanged: (String val) => provider.searchRestaurant(val),
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
        Expanded(
          flex: 10,
          child: Consumer<RestaurantProvider>(
            builder: (context, data, _) {
              if (data.state == ResultState.LOADING) {
                print(data.state);
                return LoadAnimation(
                  fileName: 'loading',
                  text: 'Sedang Memuat Data..',
                  width: 50,
                );
              } else if (data.state == ResultState.HAS_DATA) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => RestaurantCard(
                    data: data.listRestaurantResult!.restaurants![index],
                  ),
                  itemCount: data.listRestaurantResult!.restaurants!.length,
                );
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
      ],
    );
  }
}
