import 'package:flutter/material.dart';
import 'package:malay_food_cal_tracker/providers/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:malay_food_cal_tracker/models/user.dart';

class SecondRegistrationPage extends StatefulWidget {
  final String username;
  final String email;
  final String password;

  SecondRegistrationPage({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  _SecondRegistrationPageState createState() => _SecondRegistrationPageState();
}

class _SecondRegistrationPageState extends State<SecondRegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  String _selectedGender = 'Male';
  String _selectedActivityLevel = 'Sedentary';

  final List<String> _activityLevels = [
    'Sedentary',
    'Lightly active',
    'Moderately active',
    'Very active',
    'Extra active'
  ];

  void _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        final userProvider userProviders =
            Provider.of<userProvider>(context, listen: false);

        double weight1 = double.parse(_weightController.text);
        double height1 = double.parse(_heightController.text);
        int age1 = int.parse(_ageController.text);
        String activityLevel1 = _selectedActivityLevel;
        String gender1 = _selectedGender;
        String userProfile1 = '';

        User regUser = User(
          userId: '',
          username: widget.username,
          email: widget.email,
          password: widget.password,
          weight: weight1,
          height: height1,
          age: age1,
          gender: gender1,
          activityLevel: activityLevel1,
          userProfile: userProfile1,
        );

        userProviders.setUser(regUser);
        await userProviders.registerUser();
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: $e'),
            duration: Duration(seconds: 2),
          ),
        );
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 120.0),
              Column(
                children: [
                  Text(
                    'MalayFood',
                    style: TextStyle(fontSize: 32.0, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 5.0), // Add margin between widgets
              Text(
                'CalorieTracker',
                style: TextStyle(fontSize: 32.0, color: Colors.green),
              ),
              SizedBox(height: 120.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Weight (kg)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your weight';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: TextFormField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Height (cm)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your height';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your age';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedGender,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue!;
                        });
                      },
                      items: <String>['Male', 'Female'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your gender';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: _selectedActivityLevel,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedActivityLevel = newValue!;
                        });
                      },
                      items: _activityLevels.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Activity Level',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your activity level';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: _register,
                child: Text('Register'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
