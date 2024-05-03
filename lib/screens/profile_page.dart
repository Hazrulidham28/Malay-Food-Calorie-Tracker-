import 'package:flutter/material.dart';

class ProfileApp extends StatelessWidget {
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
  // Dummy user data
  final String username = "JohnDoe";
  final String email = "john.doe@example.com";
  final String gender = "Male";
  final double height = 175.0; // in centimeters
  final int age = 30;
  final String imageurl =
      'https://upload.wikimedia.org/wikipedia/commons/f/f3/Adolf_Hitler.png';

  final appBar = AppBar(
    automaticallyImplyLeading: false,
    title: Container(
      alignment: Alignment.center,
      child: Text(
        'Profile',
        textAlign: TextAlign.right,
      ),
    ),
    // Add something to the appBar if needed
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        image: NetworkImage(imageurl),
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const Text('Image not available');
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.green),
                      child:
                          const Icon(Icons.edit, color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              Column(
                children: [
                  _buildInputField(
                    context,
                    'Name',
                    username,
                    Icon(Icons.person),
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    context,
                    'Email',
                    email,
                    Icon(Icons.email),
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    context,
                    'Password',
                    '*********',
                    Icon(Icons.password),
                  ),
                  const SizedBox(height: 20),

                  // -- Form Submit Button
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                      child: const Text('LogOut'),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // -- Created Date and Delete Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent.withOpacity(0.1),
                        elevation: 0,
                        foregroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: BorderSide.none,
                      ),
                      child: const Text('Delete'),
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
            // Open bottom modal sheet when edit button is clicked
            _openEditFieldModal(context, labelText, initialValue);
          },
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
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit $labelText',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the bottom modal sheet
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showSaveConfirmationDialog(
                          context, labelText, updatedValue);
                    },
                    child: Text('Save'),
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
          title: Text('Save Changes'),
          content: Text('Are you sure you want to save the changes?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Save changes and close the dialog
                // You can add your saving logic here
                print('Updated $labelText: $updatedValue');
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Close the bottom modal sheet
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
