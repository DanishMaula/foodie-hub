// To parse this JSON data, do
//
//     final restaurant = restaurantFromJson(jsonString);

import 'dart:convert';

Restaurants restaurantFromJson(String str) => Restaurants.fromJson(json.decode(str));

String restaurantToJson(Restaurants data) => json.encode(data.toJson());

class Restaurants {
    final bool error;
    final String message;
    final int count;
    final List<RestaurantElement> restaurants;

    Restaurants({
        required this.error,
        required this.message,
        required this.count,
        required this.restaurants,
    });

    factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<RestaurantElement>.from(json["restaurants"].map((x) => RestaurantElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    };
}

class RestaurantElement {
    final String id;
    final String name;
    final String description;
    final String pictureId;
    final String city;
    final double rating;

    RestaurantElement({
        required this.id,
        required this.name,
        required this.description,
        required this.pictureId,
        required this.city,
        required this.rating,
    });

    factory RestaurantElement.fromJson(Map<String, dynamic> json) => RestaurantElement(
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
