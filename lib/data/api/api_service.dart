import 'dart:convert';

import 'package:foodie_hub/data/models/restaurant_search.dart';
import 'package:http/http.dart' as http;

import '../models/restaurant_model.dart';

class ApiService {
  late final String query;
  static const String imgUrl = 'https://restaurant-api.dicoding.dev/images/small/';
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static const String _searchRestaurant = '/search?q=';
  static const String _listRestaurant = '/list';


  Future<Restaurants> getRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + _listRestaurant));
    if (response.statusCode == 200) {
      return Restaurants.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant');
    }
  }

  Future<RestaurantElement> getRestaurantById(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));
    if (response.statusCode == 200) {
      return RestaurantElement.fromJson(jsonDecode(response.body)['restaurant']);
    } else {
      throw Exception('Failed to load restaurant');
    }
  }

  Future<RestaurantSearch> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse('${_baseUrl + _searchRestaurant}$query'));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant');
    }
  }
}
