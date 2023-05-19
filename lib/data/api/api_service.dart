import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:foodie_hub/data/models/customer_review.dart';
import 'package:foodie_hub/data/models/restaurant_detail_model.dart';
import 'package:http/http.dart' as http;

import '../models/restaurant_model.dart';

class ApiService {
  static const String imgUrl =
      'https://restaurant-api.dicoding.dev/images/small/';
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantModel> getRestaurant() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));
    if (response.statusCode == 200) {
      return RestaurantModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant');
    }
  }

  Future<Either<String, RestaurantDetail>> getRestaurantById(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));
    if (response.statusCode == 200) {
      return Right(RestaurantDetail.fromJson(jsonDecode(response.body)));
    } else {
      return left('Failed to load restaurant');
    }
  }

  Future<Either<String, CustomerReviewModel>> postReviewRestaurant(
    String id,
    String name,
    String review,
  ) async {
    final body = json.encode({'id': id, 'name': name, 'review': review});

    print('$review $id $name');

    final response = await http.post(
      Uri.parse('$_baseUrl/review'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      return Right(
        CustomerReviewModel.fromJson(
          jsonDecode(
            response.body,
          ),
        ),
      );
    } else {
      return left('Failed to load restaurant');
    }
  }
}
