import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: InputBorder.none, // Hide default border
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16.0),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          // You can add more email validation logic here
                          return null;
                        },
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
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            border: InputBorder.none, // Hide default border
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16.0),
                            prefixIcon: const Icon(Icons.key)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          // You can add more password validation logic here
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Add login logic here
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        }
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
      ),
    );
  }
}
