import 'package:dicoding_submission_restaurant_app_api/model/favourite_model.dart';
import 'package:dicoding_submission_restaurant_app_api/network/database_helper.dart';
import 'package:dicoding_submission_restaurant_app_api/provider/result_state.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class FavouriteProvider extends ChangeNotifier {
  final DatabaseHelper _database = DatabaseHelper();
  FavouriteProvider() {
    _getFavourite();
  }

  var _favouriteResult;
  String _message = '';
  ResultState _state = ResultState.LOADING;

  String get message => _message;
  get favouriteResult => _favouriteResult;
  ResultState? get state => _state;

  void addToFavourite(FavouriteModel data) async {
    await _database.addFavourite(data);
    notifyListeners();
  }

  void removeFavourite(String id) async {
    await _database.deleteFavourite(id);
    _getFavourite();
  }

  Future<bool> isFavourite(String id) async {
    final favouriteItem = await _database.getFavouriteById(id);
    return favouriteItem.isNotEmpty;
  }

  Future _getFavourite() async {
    try {
      _state = ResultState.LOADING;
      notifyListeners();

      final favourite = await _database.getFavourite();

      if (favourite.isEmpty) {
        _state = ResultState.NO_DATA;
        notifyListeners();
        return _message = 'Data Tidak Ditemukan :(';
      } else {
        _state = ResultState.HAS_DATA;
        notifyListeners();
        return _favouriteResult = favourite;
      }
    } catch (e) {
      _state = ResultState.ERROR;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}
