import 'package:flutter/material.dart';
import 'package:foodie_hub/provider/restaurant_provider.dart';
import 'package:foodie_hub/utils/style_manager.dart';
import 'package:foodie_hub/widgets/card_restaurant.dart';
import 'package:provider/provider.dart';

import '../utils/shimmer.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home-page';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to Foodie Hub',
                    style: getBlackTextStyle(
                        fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Your one stop for all your food needs.',
                    style: getBlackTextStyle(),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: _buildList(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantProvider>(builder: (context, state, _) {
      if (state.state == ResultState.Loading) {
        return const Center(child: ShimmerContainer());
      } else if (state.state == ResultState.HasData) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return CardRestaurant(restaurant: restaurant);
            });
      } else if (state.state == ResultState.NoData) {
        return Center(
          child: Material(
            child: Text(state.message),
          ),
        );
      } else if (state.state == ResultState.Error) {
        return Center(
          child: Material(
            child: Text(state.message),
          ),
        );
      } else {
        return const Center(child: Text(''));
      }
    });
  }
}
