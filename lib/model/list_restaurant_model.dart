// To parse this JSON data, do
//
//     final listRestaurantModel = listRestaurantModelFromJson(jsonString);

import 'dart:convert';

ListRestaurantModel listRestaurantModelFromJson(String str) =>
    ListRestaurantModel.fromJson(json.decode(str));

String listRestaurantModelToJson(ListRestaurantModel data) =>
    json.encode(data.toJson());

class ListRestaurantModel {
  ListRestaurantModel({
    this.error,
    this.message,
    this.count,
    this.restaurants,
  });

  final bool? error;
  final String? message;
  final int? count;
  final List<Restaurant>? restaurants;

  factory ListRestaurantModel.fromJson(Map<String, dynamic> json) =>
      ListRestaurantModel(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants!.map((x) => x.toJson())),
      };
}

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  final String? id;
  final String? name;
  final String? description;
  final String? pictureId;
  final String? city;
  final double? rating;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
