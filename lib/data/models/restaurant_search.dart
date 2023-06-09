// To parse this JSON data, do
//
//     final restaurantSearch = restaurantSearchFromJson(jsonString);

import 'dart:convert';

RestaurantSearch restaurantSearchFromJson(String str) => RestaurantSearch.fromJson(json.decode(str));

String restaurantSearchToJson(RestaurantSearch data) => json.encode(data.toJson());

class RestaurantSearch {
    final bool error;
    final int founded;
    final List<Restaurantt> restaurants;

    RestaurantSearch({
        required this.error,
        required this.founded,
        required this.restaurants,
    });

    factory RestaurantSearch.fromJson(Map<String, dynamic> json) => RestaurantSearch(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurantt>.from(json["restaurants"].map((x) => Restaurantt.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    };
}

class Restaurantt {
    final String id;
    final String name;
    final String description;
    final String pictureId;
    final String city;
    final double rating;

    Restaurantt({
        required this.id,
        required this.name,
        required this.description,
        required this.pictureId,
        required this.city,
        required this.rating,
    });

    factory Restaurantt.fromJson(Map<String, dynamic> json) => Restaurantt(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
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
