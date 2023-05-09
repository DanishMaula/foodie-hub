import 'package:flutter/material.dart';
import 'package:foodie_hub/presentation/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      routes: {
        HomePage.routeName: (context) => const HomePage(),
      },
    );
  }
}
