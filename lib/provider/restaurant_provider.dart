import 'package:dicoding_submission_restaurant_app_api/model/detail_restaurant_model.dart';
import 'package:dicoding_submission_restaurant_app_api/model/list_restaurant_model.dart';
import 'package:dicoding_submission_restaurant_app_api/network/api_service.dart';
import 'package:flutter/cupertino.dart';

enum ResultState { LOADING, NO_DATA, HAS_DATA, ERROR }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchListRestaurant();
  }

  ListRestaurantModel? _listRestaurantResult;
  String _message = '';
  ResultState _state = ResultState.LOADING;

  String get message => _message;
  ListRestaurantModel? get listRestaurantResult => _listRestaurantResult;
  ResultState? get state => _state;

  Future _fetchListRestaurant() async {
    try {
      _state = ResultState.LOADING;
      notifyListeners();

      final restaurant = await apiService.listRestaurants();

      if (restaurant!.restaurants!.isEmpty) {
        _state = ResultState.NO_DATA;
        notifyListeners();
        return _message = 'No Data';
      } else {
        _state = ResultState.HAS_DATA;
        notifyListeners();
        return _listRestaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.ERROR;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}
