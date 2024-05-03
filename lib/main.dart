import 'package:flutter/material.dart';
import 'package:malay_food_cal_tracker/providers/tflite.dart';
import 'package:provider/provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Tflite(),
        ),
      ],
      child: MaterialApp(
        title: 'Landing Page',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: LandingPage(),
        debugShowCheckedModeBanner: false, // Remove debug label
      ),
    );
  }
}
