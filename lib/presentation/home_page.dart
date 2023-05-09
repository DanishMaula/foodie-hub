import 'package:flutter/material.dart';
import 'package:foodie_hub/models/local_restaurant.dart';
import 'package:foodie_hub/utils/style_manager.dart';

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

  FutureBuilder<String> _buildList(BuildContext context) {
    return FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          final localRestaurant =
              localRestaurantFromJson(snapshot.data.toString());
          return ListView.builder(
              shrinkWrap: true,
              itemCount: localRestaurant.restaurants.length,
              itemBuilder: (context, index) {
                return _buildRestaurantItem(
                    context, localRestaurant.restaurants[index]);
              });
        });
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/detail-page', arguments: restaurant);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Hero(
                    tag: restaurant.pictureId,
                    child: Image.network(
                      restaurant.pictureId,
                      height: 150,
                      width: 145,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        restaurant.name,
                        style: getBlackTextStyle(fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        restaurant.description,
                        style: getBlackTextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.location_on,
                            color: Colors.grey,
                            size: 17,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            restaurant.city,
                            style: getBlackTextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}
