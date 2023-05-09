import 'package:flutter/material.dart';
import 'package:foodie_hub/models/local_restaurant.dart';

import '../utils/style_manager.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail-page';

  final Restaurant restaurantModel;

  const DetailPage({super.key, required this.restaurantModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (context, isScrolled) {
        return [
          _buildSliverAppBar(context),
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
                    restaurantModel.city,
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
                    restaurantModel.rating.toString(),
                    style: getBlackTextStyle(),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Description',
                style: getBlackTextStyle(
                    fontWeight: FontWeight.w600, fontSize: 22),
              ),
              Text(
                restaurantModel.description,
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
                'Foods',
                style: getBlackTextStyle(),
              ),
              const SizedBox(
                height: 10,
              ),
              _menuList(restaurantModel.menus.foods),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Drinks',
                style: getBlackTextStyle(),
              ),
              const SizedBox(
                height: 10,
              ),
              _menuList(restaurantModel.menus.drinks),
            ],
          ),
        ),
      ),
    ));
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      // floating: true,
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
            tag: restaurantModel.pictureId,
            child: Image.network(
              restaurantModel.pictureId,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          restaurantModel.name,
          style: getWhiteTextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        // titlePadding: const EdgeInsets.only(top: 16, left: 20),
      ),
    );
  }

  SizedBox _menuList(List<Drink> menu) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: menu.length,
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
                menu[index].name,
                style: getBlackTextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          );
        },
      ),
    );
  }
}
