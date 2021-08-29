import 'dart:convert';

import 'package:dicoding_submission_restaurant_app_api/model/detail_restaurant_model.dart';
import 'package:dicoding_submission_restaurant_app_api/model/list_restaurant_model.dart';

import 'package:http/http.dart' as http;

class ApiService {
  static final String _url = 'https://restaurant-api.dicoding.dev/';

  Future<ListRestaurantModel?> listRestaurants() async {
    final response = await http.get(Uri.parse(_url + '/list'));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return ListRestaurantModel.fromJson(jsonData);
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  Future<DetailRestaurantModel?> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_url + '/detail/${id}'));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print(jsonData);
      return DetailRestaurantModel.fromJson(jsonData);
    } else {
      throw Exception('Gagal memuat data');
    }
  }
}
