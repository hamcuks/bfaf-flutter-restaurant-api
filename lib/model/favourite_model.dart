class FavouriteModel {
  FavouriteModel({
    this.id,
    this.name,
    this.pictureId,
    this.city,
    this.rating,
  });

  final String? id;
  final String? name;
  final String? pictureId;
  final String? city;
  final String? rating;

  factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
        id: json["id"],
        name: json["name"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
