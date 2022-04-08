class RestaurantResult {
  RestaurantResult({required this.restaurants});

  List<Restaurant> restaurants;

  factory RestaurantResult.fromJson(Map<dynamic, dynamic> json) =>
      RestaurantResult(
        restaurants: List<Restaurant>.from(
            (json['restaurants'] as List).map((e) => Restaurant.fromJson(e))),
      );

  Map<String, dynamic> toJson() =>
      {"restaurants": List<dynamic>.from(restaurants.map((e) => e.toJson()))};
}

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  String rating;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toString(),
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
