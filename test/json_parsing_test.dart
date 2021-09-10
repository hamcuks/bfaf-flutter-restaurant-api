import 'package:dicoding_submission_restaurant_app_api/network/api_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should complete when parsing json', () async {
    // arrange
    ApiService _apiService = ApiService();

    // act
    var data = await _apiService.listRestaurants();

    // assert
    var result = data!.error;

    expect(!result!, true);
  });
}
