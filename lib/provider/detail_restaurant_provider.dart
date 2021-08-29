import 'package:dicoding_submission_restaurant_app_api/model/detail_restaurant_model.dart';
import 'package:dicoding_submission_restaurant_app_api/network/api_service.dart';
import 'package:dicoding_submission_restaurant_app_api/provider/result_state.dart';
import 'package:flutter/cupertino.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailRestaurantProvider({required this.apiService, required this.id}) {
    _fetchDetailRestaurant(id);
  }

  DetailRestaurantModel? _detailRestaurantResult;
  String _message = '';
  ResultState _state = ResultState.LOADING;

  String get message => _message;
  DetailRestaurantModel? get detailRestaurantResult => _detailRestaurantResult;
  ResultState? get state => _state;

  Future _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.LOADING;
      notifyListeners();

      final restaurant = await apiService.detailRestaurant(id);

      if (restaurant!.restaurant == null) {
        print('error');
        _state = ResultState.NO_DATA;
        notifyListeners();
        return _message = 'No Data';
      } else {
        print('has data');
        _state = ResultState.HAS_DATA;
        notifyListeners();
        return _detailRestaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.ERROR;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}
