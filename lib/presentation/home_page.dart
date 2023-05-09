import 'package:flutter/material.dart';
import 'package:foodie_hub/utils/style_manager.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home-page';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
          return ListView.builder(
              shrinkWrap: true,
              itemCount: 100,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  height: 100,
                  color: Colors.red,
                );
              });
        });
  }
}
