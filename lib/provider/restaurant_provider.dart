import 'package:dicoding_submission_restaurant_app_api/helper/connectivity_state.dart';
import 'package:dicoding_submission_restaurant_app_api/model/list_restaurant_model.dart';
import 'package:dicoding_submission_restaurant_app_api/model/search_restaurant_model.dart';
import 'package:dicoding_submission_restaurant_app_api/network/api_service.dart';
import 'package:dicoding_submission_restaurant_app_api/provider/result_state.dart';
import 'package:flutter/material.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchListRestaurant();
  }

  //var connectivityResult =

  var _listRestaurantResult;
  String _message = '';
  ResultState _state = ResultState.LOADING;

  String get message => _message;
  get listRestaurantResult => _listRestaurantResult;
  ResultState? get state => _state;

  Future<bool> get _checkConnection async {
    return await ConnectivityState().isConnectedToNetwork();
  }

  Future _fetchListRestaurant() async {
    try {
      _state = ResultState.LOADING;
      notifyListeners();

      if (await _checkConnection) {
        final restaurant = await apiService.listRestaurants();

        if (restaurant!.restaurants!.isEmpty) {
          _state = ResultState.NO_DATA;
          notifyListeners();
          return _message = 'Data Tidak Ditemukan :(';
        } else {
          _state = ResultState.HAS_DATA;
          notifyListeners();
          return _listRestaurantResult = restaurant;
        }
      } else {
        _state = ResultState.NO_INTERNET;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.ERROR;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }

  Future searchRestaurant(String keyword) async {
    try {
      _state = ResultState.LOADING;
      notifyListeners();

      if (await _checkConnection) {
        final restaurant = await apiService.searchRestaurant(keyword);

        if (restaurant!.restaurants!.isEmpty) {
          _state = ResultState.NO_DATA;
          notifyListeners();
          return _message = 'Pencarian Tidak Ditemukan :(';
        } else {
          _state = ResultState.HAS_DATA;
          notifyListeners();
          return _listRestaurantResult = restaurant;
        }
      } else {
        _state = ResultState.NO_INTERNET;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.ERROR;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}
