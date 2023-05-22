import 'package:flutter/material.dart';
import 'package:foodie_hub/data/api/api_service.dart';
import 'package:foodie_hub/data/models/restaurant_search.dart';
import 'package:foodie_hub/provider/restaurant_provider.dart';

import '../data/models/restaurant_detail_model.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService});

  late RestaurantSearch _searchResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  RestaurantSearch get result => _searchResult;
  ResultState get state => _state;

  Future performSearch(query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.searchRestaurant(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _searchResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
