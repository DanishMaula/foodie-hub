import 'package:flutter/material.dart';
import 'package:foodie_hub/data/api/api_service.dart';
import 'package:foodie_hub/data/models/customer_review.dart';
import 'package:foodie_hub/data/models/restaurant_model.dart';

import '../data/models/restaurant_detail_model.dart';

enum ResultStateCustomer { Loading, NoData, HasData, Error }

class RestaurantReviewProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantReviewProvider({required this.apiService});

  late CustomerReviewModel _restaurantCustomerReview;
  ResultStateCustomer? _state;
  String _message = '';

  String get message => _message;

  CustomerReviewModel get result => _restaurantCustomerReview;



  ResultStateCustomer? get state => _state;


  Future<dynamic> postReviewRestaurant(
      String id, String name, String review) async {
    try {
      _state = ResultStateCustomer.Loading;
      notifyListeners();
      final restaurantPostReview = await apiService.postReviewRestaurant(id, name, review);
      print(restaurantPostReview.toString());
      restaurantPostReview.fold((error) {
        _state = ResultStateCustomer.NoData;
        notifyListeners();
        return _message = 'Gagal Post Review';
      }, (data) {
        _state = ResultStateCustomer.HasData;
        notifyListeners();
        return _restaurantCustomerReview = data;
      });
    } catch (e) {
      _state = ResultStateCustomer.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
