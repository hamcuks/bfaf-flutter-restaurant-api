import 'dart:convert';
import 'package:dicoding_submission_restaurant_app_api/model/detail_restaurant_model.dart';
import 'package:dicoding_submission_restaurant_app_api/model/list_restaurant_model.dart';
import 'package:dicoding_submission_restaurant_app_api/model/search_restaurant_model.dart';

import 'package:http/http.dart' show Client;

class ApiService {
  static final String apiUrl = 'https://restaurant-api.dicoding.dev/';

  final Client client;
  ApiService(this.client);

  Future listRestaurants() async {
    final response = await client.get(Uri.parse(apiUrl + 'list'));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return ListRestaurantModel.fromJson(jsonData);
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  Future<DetailRestaurantModel> detailRestaurant(String id) async {
    final response = await client.get(Uri.parse(apiUrl + '/detail/$id'));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return DetailRestaurantModel.fromJson(jsonData);
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  Future<SearchRestaurantModel> searchRestaurant(String text) async {
    final response = await client.get(Uri.parse(apiUrl + '/search?q=$text'));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print(jsonData);
      return SearchRestaurantModel.fromJson(jsonData);
    } else {
      throw Exception('Gagal memuat data');
    }
  }
}
