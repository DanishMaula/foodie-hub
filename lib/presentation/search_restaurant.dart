import 'package:flutter/material.dart';
import 'package:foodie_hub/provider/search_restaurant_provider.dart';
import 'package:foodie_hub/widgets/card_search_restaurant.dart';
import 'package:provider/provider.dart';

import '../provider/restaurant_provider.dart';
import '../utils/shimmer.dart';
import '../widgets/card_restaurant.dart';
import '../widgets/search_widget.dart';

class SearchRestaurant extends StatelessWidget {
  static const String routeName = '/search-restaurant';

  const SearchRestaurant({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();
    final SearchRestaurantProvider searchProvider =
        Provider.of<SearchRestaurantProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            children: [
              SearchWidget(
                searchController: _searchController,
                onChanged: (value) {
                  searchProvider.performSearch(value);
                },
              ),
              const SizedBox(height: 24),
              _buildSearchedList(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchedList(BuildContext context) {
    return Consumer<SearchRestaurantProvider>(builder: (context, state, _) {
      if (state.state == ResultState.Loading) {
        return const Center(child: ShimmerContainer());
      } else if (state.state == ResultState.HasData) {
        return ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return CardSearchRestaurant(
                restaurant: restaurant,
              );
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
      } else if (state.state == null) {
        return const Center(child: Text(''));
      } else {
        return const Center(child: Text(''));
      }
    });
  }
}
