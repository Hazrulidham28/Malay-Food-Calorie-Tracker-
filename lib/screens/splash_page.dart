import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/userProvider.dart';
import 'home_page.dart';
import 'landing_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _visible = true;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });

    _animationController.forward();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    final userProviders = Provider.of<userProvider>(context, listen: false);
    await userProviders.checkLoginStatus();

    // Display the splash screen for a few seconds
    await Future.delayed(Duration(seconds: 3));

    if (userProviders.status == AuthStatus.Authenticated) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Opacity(
              opacity: _animationController.value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'MalayFood',
                    style: TextStyle(fontSize: 32.0, color: Colors.black),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'CalorieTracker',
                    style: TextStyle(fontSize: 32.0, color: Colors.green),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
