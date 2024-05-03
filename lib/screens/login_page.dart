import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
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
                const SizedBox(height: 100.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(20.0), // Set border radius here
                    border: Border.all(
                        color: Colors.grey), // Optional: Add border color
                  ),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: InputBorder.none, // Hide default border
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(20.0), // Set border radius here
                    border: Border.all(
                        color: Colors.grey), // Optional: Add border color
                  ),
                  child: SizedBox(
                    width: 350,
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          border: InputBorder.none, // Hide default border
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.0),
                          prefixIcon: Icon(Icons.key)),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add navigation logic here
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Set button border radius here
                      ),
                    ),
                    child: Text('Login'),
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
