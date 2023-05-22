import 'package:flutter/material.dart';
import 'package:foodie_hub/data/api/api_service.dart';
import 'package:foodie_hub/data/models/restaurant_model.dart';
import 'package:foodie_hub/provider/restaurant_detail_provider.dart';
import 'package:provider/provider.dart';

import '../data/models/restaurant_detail_model.dart';
import '../provider/restaurant_review_provider.dart';
import '../utils/style_manager.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail-page';

  final RestaurantElement restaurant;

  DetailPage({super.key, required this.restaurant});

  TextEditingController reviewController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final detailProvider =
    //     Provider.of<RestaurantDetailProvider>(context, listen: false);
    final reviewProvider = Provider.of<RestaurantReviewProvider>(context, listen: false);

    //
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // detailProvider.fetchDetailRestaurant(id.toString());
      // reviewProvider.postReviewRestaurant('','','');
      reviewProvider.resetState();
    });

    return ChangeNotifierProvider(
      create: (context) => RestaurantDetailProvider(
          apiService: ApiService(), restaurant: restaurant),
      child: Consumer<RestaurantDetailProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return _buildScaffoldCenter(
                context, const CircularProgressIndicator());
          } else if (state.state == ResultState.HasData) {
            return _buildScaffold(context, state.result.restaurant);
          } else if (state.state == ResultState.NoData) {
            return _buildScaffoldCenter(context, Text(state.message));
          } else if (state.state == ResultState.Error) {
            return _buildScaffoldCenter(context, Text(state.message));
          } else {
            return _buildScaffoldCenter(context, Text(state.message));
          }
        },
      ),
    );
  }

  Widget _buildScaffoldCenter(BuildContext context, Widget? child) {
    return Scaffold(
      body: Center(
        child: child,
      ),
    );
  }

  Widget _buildScaffold(BuildContext context, Restaurant restaurant) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            _buildSliverAppBar(context, restaurant),
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.redAccent,
                    ),
                    Text(
                      restaurant.city,
                      style: getBlackTextStyle(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Text(
                      restaurant.rating.toString(),
                      style: getBlackTextStyle(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Categories : ',
                  style: getBlackTextStyle(
                      fontWeight: FontWeight.w600, fontSize: 22),
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildList(restaurant.categories),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Description',
                  style: getBlackTextStyle(
                      fontWeight: FontWeight.w600, fontSize: 22),
                ),
                Text(
                  restaurant.description,
                  style: getBlackTextStyle(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Menu',
                  style: getBlackTextStyle(
                      fontWeight: FontWeight.w600, fontSize: 22),
                ),
                Text(
                  'Foods :',
                  style: getBlackTextStyle(),
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildList(restaurant.menus.foods),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Drinks : ',
                  style: getBlackTextStyle(),
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildList(restaurant.menus.drinks),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Review',
                  style: getBlackTextStyle(
                      fontWeight: FontWeight.w600, fontSize: 22),
                ),
                _buildReviewColumn(context),
                const SizedBox(
                  height: 10,
                ),
                _buildCustomerReview(restaurant.customerReviews),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReviewColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Write a Review',
          style: getBlackTextStyle(),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: nameController,
          maxLines: 1,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your Name',
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: reviewController,
          maxLines: 3,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your review',
          ),
        ),
        const SizedBox(height: 10),
        Consumer<RestaurantReviewProvider>(builder: (context, state, _) {
          return ElevatedButton(
            onPressed: () {
              state.postReviewRestaurant(
                  restaurant.id, nameController.text, reviewController.text);
            },
            child: const Text('Submit'),
          );
        }),
      ],
    );
  }

  Consumer _buildCustomerReview(List<CustomerReview> list) {
    return Consumer<RestaurantReviewProvider>(
      builder: (context, state, _) {
        print(state.state);
        if (state.state == ResultStateCustomer.Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultStateCustomer.HasData) {
          return _buildListCustomerReview(state.result.customerReviews);
        } else if (state.state == ResultStateCustomer.NoData) {
          return Text(state.message);
        } else if (state.state == ResultStateCustomer.Error) {
          return Text(state.message);
        } else if (state.state == null) {
          return _buildListCustomerReview(list);
        } else {
          return Text(state.message);
        }
      },
    );
  }

  Widget _buildListCustomerReview(List<CustomerReview> list) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: list.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            tileColor: Colors.grey.withOpacity(0.2),
            title: Text(list[index].name),
            trailing: Text(list[index].date),
            subtitle: Text(list[index].review),
          ),
        );
      },
    );
  }

  SizedBox _buildList(List<dynamic> list) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.grey.withOpacity(0.2),
            ),
            margin: const EdgeInsets.only(right: 10),
            height: 20,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Center(
              child: Text(
                list[index].name,
                style: getBlackTextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          );
        },
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context, Restaurant restaurant) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 230,
      backgroundColor: Colors.black,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: CircleAvatar(
          radius: 2,
          backgroundColor: Colors.black.withOpacity(0.3),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          foregroundDecoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black,
                Colors.transparent,
                Colors.transparent,
                Colors.black
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0, 0, 1],
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Hero(
            tag: restaurant.pictureId,
            child: Image.network(
              '${ApiService.imgUrl}${restaurant.pictureId}',
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          restaurant.name,
          style: getWhiteTextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        // titlePadding: const EdgeInsets.only(top: 16, left: 20),
      ),
    );
  }
}
