import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:malay_food_cal_tracker/providers/tflite.dart';
import 'package:malay_food_cal_tracker/providers/userProvider.dart';
import 'package:malay_food_cal_tracker/screens/login_page.dart';
import 'package:malay_food_cal_tracker/screens/profile_page.dart';
import 'package:provider/provider.dart';
import './screens/home_page.dart';
import './screens/landing_page.dart';
import './screens/registeration_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Tflite(),
        ),
        ChangeNotifierProvider(
          create: (context) => userProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Landing Page',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: LandingPage(),
        debugShowCheckedModeBanner: false, // Remove debug label
        routes: {
          '/login': (context) => LoginPage(),
          '/register': (context) => RegistrationPage(),
          '/home': (context) => HomePage(),
          '/profile': (context) => ProfilePage(),
        },
      ),
    );
  }
}
