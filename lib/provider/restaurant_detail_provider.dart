import 'package:flutter/foundation.dart';
import 'package:foodie_hub/data/api/api_service.dart';
import 'package:foodie_hub/data/models/restaurant_detail_model.dart';
import 'package:foodie_hub/data/models/restaurant_model.dart';
import 'package:foodie_hub/provider/restaurant_provider.dart';
import 'package:provider/provider.dart';

import '../data/models/customer_review.dart';


class RestaurantDetailProvider extends ChangeNotifier {
  RestaurantElement restaurant;
  final ApiService apiService;

  RestaurantDetailProvider(
      {required this.apiService, required this.restaurant}) {
    _fetchDetailRestaurant();
  }

  late RestaurantDetail _restaurantDetail;

  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantDetail get result => _restaurantDetail;


  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurantDetail =
          await apiService.getRestaurantById(restaurant.id);
      print(restaurantDetail.toString());

      restaurantDetail.fold((error) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      }, (data) {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantDetail = data;
      });
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

// Future<dynamic> postReviewRestaurant(
//   String id,
//   String name,
//   String review,
// ) async {
//   try {
//     _state = ResultState.Loading;
//     notifyListeners();
//     final restaurantPostReview =
//         await apiService.postReviewRestaurant(id, name, review);
//     print(restaurantPostReview.toString());
//     restaurantPostReview.fold((error) {
//       _state = ResultState.NoData;
//       notifyListeners();
//       return _message = 'Gagal Post Review';
//     }, (data) {
//       _state = ResultState.HasData;
//       notifyListeners();
//       return _restaurantCustomerReview = data;
//     });
//   } catch (e) {
//     _state = ResultState.Error;
//     notifyListeners();
//     return _message = 'Error --> $e';
//   }
// }
}
