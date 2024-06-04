import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malay_food_cal_tracker/providers/tflite.dart';
import 'package:malay_food_cal_tracker/providers/userProvider.dart';
import 'package:malay_food_cal_tracker/screens/firstRegister_page.dart';
import 'package:malay_food_cal_tracker/screens/login_page.dart';
import 'package:malay_food_cal_tracker/screens/profile_page.dart';
import 'package:malay_food_cal_tracker/screens/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/home_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPreferences.getInstance();
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
          fontFamily: GoogleFonts.ruda().fontFamily,
          primarySwatch: Colors.green,
          // textTheme: TextTheme(
          //     titleMedium: GoogleFonts.acme(), titleSmall: GoogleFonts.acme()),
        ),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false, // Remove debug label
        routes: {
          '/login': (context) => LoginPage(),
          '/register': (context) => FirstRegistrationPage(),
          '/home': (context) => HomePage(),
          '/profile': (context) => ProfilePage(),
        },
      ),
    );
  }
}
