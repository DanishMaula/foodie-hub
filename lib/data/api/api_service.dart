import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/restaurant_model.dart';

class ApiService {
  static const String imgUrl = 'https://restaurant-api.dicoding.dev/images/small/';
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/list';

  Future<Restaurant> getRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      return Restaurant.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant');
    }
  }
}
