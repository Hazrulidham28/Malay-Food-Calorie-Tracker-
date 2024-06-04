import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';
import '../providers/userProvider.dart';

class ProfileApp extends StatefulWidget {
  @override
  State<ProfileApp> createState() => _ProfileAppState();
}

class _ProfileAppState extends State<ProfileApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProviders = Provider.of<userProvider>(context, listen: false);
    final user = userProviders.userR;
    final String imageurl =
        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
    final List<String> _activityLevels = [
      'Sedentary',
      'Lightly active',
      'Moderately active',
      'Very active',
      'Extra active'
    ];

//method to loggout the user and navigate to login page
    void _userLogout() {
      try {
        userProviders.logoutUser();
        //navigate to login page after user logout
        Navigator.pushReplacementNamed(context, '/login');
      } catch (e) {
        print('Error during logout: $e');
      }
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          //padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                  elevation: 9,
                  margin: EdgeInsets.all(0),
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        15), // Adjust the radius as needed
                  ),
                  child: Container(
                    width: 380,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: 90,
                                      height: 90,
                                      child: ClipOval(
                                        child: Image.network(
                                          imageurl,
                                          fit: BoxFit.cover,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return const Text(
                                                'Image not available');
                                          },
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 55,
                                      left: 55,
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.white,
                                        ),
                                        child: IconButton(
                                          icon: Icon(Icons.edit,
                                              color: Colors.green, size: 20),
                                          onPressed: () {
                                            // Handle edit profile picture action
                                            //_openEditProfilePictureModal(context);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${user?.age} years old',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user!.username,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${userProviders.getBmi()}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${user.weight.toStringAsFixed(0)} Kg',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: 60,
                                    ),
                                    Text(
                                      '${user.height.toStringAsFixed(0)} Cm',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                  // Profile Picture with Edit Button
                  // Stack(
                  //   alignment: Alignment.center,
                  //   children: [
                  //     Card(
                  //       elevation: 9,
                  //       margin: EdgeInsets.all(0),
                  //       color: Colors.green,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(
                  //             15), // Adjust the radius as needed
                  //       ),
                  //       child: Container(
                  //         width: 380,
                  //         height: 150,
                  //         // decoration: BoxDecoration(
                  //         //   color: Colors.green,
                  //         //   borderRadius: BorderRadius.circular(20),
                  //         // ),
                  //       ),
                  //     ),
                  //     Positioned(
                  //       left: 17,
                  //       top: 32,
                  //       child: SizedBox(
                  //         width: 90,
                  //         height: 90,
                  //         child: ClipOval(
                  //           child: Image.network(
                  //             imageurl,
                  //             fit: BoxFit.cover,
                  //             errorBuilder: (BuildContext context, Object exception,
                  //                 StackTrace? stackTrace) {
                  //               return const Text('Image not available');
                  //             },
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  // Positioned(
                  //   top: 90,
                  //   left: 80,
                  //   child: Container(
                  //     width: 35,
                  //     height: 35,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(100),
                  //       color: Colors.white,
                  //     ),
                  //     child: IconButton(
                  //       icon: Icon(Icons.edit, color: Colors.green, size: 20),
                  //       onPressed: () {
                  //         // Handle edit profile picture action
                  //         //_openEditProfilePictureModal(context);
                  //       },
                  //     ),
                  //   ),
                  // ),
                  //     Positioned(
                  //       top: 25,
                  //       left: 140,
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  // Text(
                  //   user!.username,
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // Text(
                  //   '${user.age} Years old',
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 16,
                  //   ),
                  // ),
                  //           const SizedBox(height: 15),
                  // Text(
                  //   '${user.weight.toStringAsFixed(0)} Kg',
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 16,
                  //   ),
                  // ),
                  //         ],
                  //       ),
                  //     ),
                  //     Positioned(
                  //       top: 58,
                  //       right: 30,
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  // const SizedBox(height: 5),
                  // Text(
                  //   '${userProviders.getBmi()}',
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 16,
                  //   ),
                  // ),
                  //           const SizedBox(height: 15),
                  // Text(
                  //   '${user.height.toStringAsFixed(0)} Cm',
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 16,
                  //   ),
                  // ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  ),
              const SizedBox(height: 10),

              // User Information Fields

              const SizedBox(height: 20),
              Container(
                width: 380,
                child: _buildViewField(
                  context,
                  'Email',
                  user!.email,
                  Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 380,
                child: _buildInputField(
                  context,
                  'User Name',
                  user.username,
                  Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 380,
                child: _buildInputField(
                  context,
                  'Activity level',
                  user.activityLevel,
                  Icon(Icons.health_and_safety),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 380,
                child: _buildInputField(
                  context,
                  'Age',
                  user.age.toString(),
                  Icon(Icons.format_list_numbered),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 380,
                child: _buildInputField(
                  context,
                  'Weight',
                  user.weight.toString(),
                  Icon(Icons.monitor_weight),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 380,
                child: _buildInputField(
                  context,
                  'Gender',
                  user.gender,
                  Icon(Iconsax.profile_2user),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 380,
                child: _buildInputField(
                  context,
                  'Height',
                  user.height.toString(),
                  Icon(Icons.height),
                ),
              ),
              const SizedBox(height: 20),

              // Log Out Button
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: _userLogout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Log Out'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      BuildContext context, String labelText, String initialValue, Icon icon) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            _openEditFieldModal(context, labelText, initialValue);
          },
        ),
      ),
      child: Text(initialValue),
    );
  }

  Widget _buildViewField(
      BuildContext context, String labelText, String initialValue, Icon icon) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(initialValue),
    );
  }

  void _openEditFieldModal(
      BuildContext context, String labelText, String initialValue) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        String updatedValue = initialValue;

        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit $labelText',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: initialValue,
                onChanged: (value) {
                  updatedValue = value;
                },
                decoration: InputDecoration(
                  labelText: labelText,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the modal sheet
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showSaveConfirmationDialog(
                          context, labelText, updatedValue);
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSaveConfirmationDialog(
      BuildContext context, String labelText, String updatedValue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Save Changes'),
          content: const Text('Are you sure you want to save the changes?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Save changes logic here
                print('Updated $labelText: $updatedValue');
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Close the modal sheet
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
