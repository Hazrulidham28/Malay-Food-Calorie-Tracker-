import 'package:flutter/material.dart';
import 'registeration_page.dart';
import 'login_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  //named route

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 200),
            const Column(
              children: [
                Text(
                  'MalayFood',
                  style: TextStyle(fontSize: 32.0, color: Colors.black),
                ),
                SizedBox(height: 5.0), // Add margin between widgets
                Text(
                  'CalorieTracker',
                  style: TextStyle(fontSize: 32.0, color: Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 200.0), // Reduced SizedBox height
            Column(
              children: [
                SizedBox(
                  width: 250, // Set button width to match parent width
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Set border radius here
                      ),
                    ),
                    child: const Text('Get Started'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2.0), // Reduced SizedBox height
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: const Text(
                    'Has an account? Login',
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
