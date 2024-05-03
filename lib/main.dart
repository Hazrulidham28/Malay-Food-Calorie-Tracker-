import 'package:flutter/material.dart';
import './screens/home_page.dart';
import './screens/landing_page.dart';
import './screens/registeration_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Landing Page',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LandingPage(),
      debugShowCheckedModeBanner: false, // Remove debug label
    );
  }
}
