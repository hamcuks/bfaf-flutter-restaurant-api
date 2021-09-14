import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dicoding_submission_restaurant_app_api/model/list_restaurant_model.dart';
import 'package:dicoding_submission_restaurant_app_api/network/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'json_parsing_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Parsing Json Test: ', () {
    final responseExpected = ListRestaurantModel(
      error: false,
      message: 'success',
      count: 20,
      restaurants: [],
    );

    final mockClient = MockClient();

    test('return list resto from API when success', () async {
      var json = jsonEncode(responseExpected.toJson());

      when(mockClient.get(Uri.parse(ApiService.apiUrl + 'list')))
          .thenAnswer((_) async => http.Response(json, 200));

      expect(await ApiService(mockClient).listRestaurants(),
          isA<ListRestaurantModel>());
    });
  });
}
