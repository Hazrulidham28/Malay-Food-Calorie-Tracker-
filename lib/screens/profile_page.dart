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

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Profile')),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Picture with Edit Button
            Stack(
              alignment: Alignment.center,
              children: [
                Card(
                  elevation: 9,
                  margin: EdgeInsets.all(0),
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        15), // Adjust the radius as needed
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    // decoration: BoxDecoration(
                    //   color: Colors.green,
                    //   borderRadius: BorderRadius.circular(20),
                    // ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 20,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: ClipOval(
                      child: Image.network(
                        imageurl,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const Text('Image not available');
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 90,
                  left: 80,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.edit, color: Colors.green, size: 20),
                      onPressed: () {
                        // Handle edit profile picture action
                        //_openEditProfilePictureModal(context);
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 25,
                  left: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user!.username,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Age: ${user.age}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Weight: ${user.weight.toStringAsFixed(0)} Kg',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 62,
                  right: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        'Height: ${user.height.toStringAsFixed(0)} Cm',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Status: ${userProviders.getBmi()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // User Information Fields

            const SizedBox(height: 20),
            _buildViewField(
              context,
              'Email',
              user!.email,
              Icon(Icons.email),
            ),
            const SizedBox(height: 20),
            _buildInputField(
              context,
              'User Name',
              user.username,
              Icon(Icons.person),
            ),
            const SizedBox(height: 20),
            _buildInputField(
              context,
              'Activity level',
              user.activityLevel,
              Icon(Icons.health_and_safety),
            ),
            const SizedBox(height: 20),
            _buildInputField(
              context,
              'Age',
              user.age.toString(),
              Icon(Icons.format_list_numbered),
            ),
            const SizedBox(height: 20),
            _buildInputField(
              context,
              'Weight',
              user.weight.toString(),
              Icon(Icons.monitor_weight),
            ),
            const SizedBox(height: 20),
            _buildInputField(
              context,
              'Gender',
              user.gender,
              Icon(Iconsax.profile_2user),
            ),
            const SizedBox(height: 20),
            _buildInputField(
              context,
              'Height',
              user.height.toString(),
              Icon(Icons.height),
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
