import 'package:flutter/material.dart';
import 'package:malay_food_cal_tracker/controllers/userServices.dart';
import 'package:malay_food_cal_tracker/widgets/main_page_widgets.dart';
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

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
  // Function? callback;

  // ProfilePage(this.callback);
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userProviders = Provider.of<userProvider>(context, listen: false);
    final user = userProviders.userR;
    final String imageurl =
        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
    final userService _userService = userService();

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
                                            _openImageSourceSelectionModal(
                                                context);
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
                  )),
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
                child: _buildInputField(context, 'User Name', user.username,
                    Icon(Icons.person), userProviders),
              ),
              const SizedBox(height: 20),
              Container(
                width: 380,
                child: _buildInputField(
                    context,
                    'Activity level',
                    user.activityLevel,
                    Icon(Icons.health_and_safety),
                    userProviders),
              ),
              const SizedBox(height: 20),
              Container(
                width: 380,
                child: _buildInputField(context, 'Age', user.age.toString(),
                    Icon(Icons.format_list_numbered), userProviders),
              ),
              const SizedBox(height: 20),
              Container(
                width: 380,
                child: _buildInputField(
                    context,
                    'Weight',
                    user.weight.toString(),
                    Icon(Icons.monitor_weight),
                    userProviders),
              ),
              const SizedBox(height: 20),
              Container(
                width: 380,
                child: _buildInputField(context, 'Gender', user.gender,
                    Icon(Iconsax.profile_2user), userProviders),
              ),
              const SizedBox(height: 20),
              Container(
                width: 380,
                child: _buildInputField(context, 'Height',
                    user.height.toString(), Icon(Icons.height), userProviders),
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

  Widget _buildInputField(BuildContext context, String labelText,
      String initialValue, Icon icon, userProvider providers) {
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
            if (labelText == 'Age' ||
                labelText == 'Weight' ||
                labelText == 'Height') {
              _openEditFieldModalNum(
                  context, labelText, initialValue, providers);
            } else if (labelText == 'Activity level') {
              _openEditFieldModalListActivity(
                  context, labelText, initialValue, providers);
            } else if (labelText == 'Gender') {
              _openEditFieldModalListGender(
                  context, labelText, initialValue, providers);
            } else {
              _openEditFieldModal(context, labelText, initialValue, providers);
            }
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

  void _openEditFieldModal(BuildContext context, String labelText,
      String initialValue, userProvider Providers) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      builder: (BuildContext context) {
        String updatedValue = initialValue;

        return Container(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 40),
              Text(
                ' Edit $labelText',
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
                          context, labelText, updatedValue, Providers);
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

  void _openEditFieldModalList(BuildContext context, String labelText,
      String initialValue, userProvider providers) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      builder: (BuildContext context) {
        String updatedValue = initialValue;

        return Container(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 40),
              Text(
                ' Edit $labelText',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
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
                          context, labelText, updatedValue, providers);
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

  void _openEditFieldModalNum(BuildContext context, String labelText,
      String initialValue, userProvider providers) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      builder: (BuildContext context) {
        String updatedValue = initialValue;

        return Container(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 40),
              Text(
                ' Edit $labelText',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
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
                      Navigator.pop(context);
                      _showSaveConfirmationDialog(
                          context, labelText, updatedValue, providers);
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

  void _openEditFieldModalListGender(BuildContext context, String labelText,
      String initialValue, userProvider providers) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      builder: (BuildContext context) {
        String selectedGender = initialValue;

        return Container(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 40),
              Text(
                '  Edit $labelText',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text('Male'),
                leading: Radio<String>(
                  value: 'Male',
                  groupValue: selectedGender,
                  onChanged: (String? value) {
                    selectedGender = value!;
                    Navigator.pop(context); // Close the modal sheet
                    _showSaveConfirmationDialog(
                        context, labelText, selectedGender, providers);
                  },
                ),
              ),
              ListTile(
                title: const Text('Female'),
                leading: Radio<String>(
                  value: 'Female',
                  groupValue: selectedGender,
                  onChanged: (String? value) {
                    selectedGender = value!;
                    Navigator.pop(context); // Close the modal sheet
                    _showSaveConfirmationDialog(
                        context, labelText, selectedGender, providers);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the modal sheet
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _openEditFieldModalListActivity(BuildContext context, String labelText,
      String initialValue, userProvider providers) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      builder: (BuildContext context) {
        String selectedActivityLevel = initialValue;
        final List<String> _activityLevels = [
          'Sedentary',
          'Lightly active',
          'Moderately active',
          'Very active',
          'Extra active'
        ];

        return Container(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 40),
              Text(
                '  Edit $labelText',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              for (String activity in _activityLevels)
                ListTile(
                  title: Text(activity),
                  leading: Radio<String>(
                    value: activity,
                    groupValue: selectedActivityLevel,
                    onChanged: (String? value) {
                      selectedActivityLevel = value!;
                      Navigator.pop(context); // Close the modal sheet
                      _showSaveConfirmationDialog(
                          context, labelText, selectedActivityLevel, providers);
                    },
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the modal sheet
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _openImageSourceSelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Image Source',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  // Handle camera selection logic here
                  Navigator.pop(context); // Close the modal sheet
                  // _pickImageFromCamera();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  // Handle gallery selection logic here
                  Navigator.pop(context); // Close the modal sheet
                  // _pickImageFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSaveConfirmationDialog(BuildContext context, String labelText,
      String updatedValue, userProvider providers) {
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
              onPressed: () async {
                final userService _userService = userService();
                String message;

                try {
                  switch (labelText) {
                    case 'Age':
                      int age = int.parse(updatedValue);
                      await _userService.updateAge(age);
                      providers.userR!.age = age;
                      message = 'Age updated successfully!';
                      break;
                    case 'Activity level':
                      await _userService.updateActivity(updatedValue);
                      providers.userR!.activityLevel = updatedValue;
                      message = 'Activity level updated successfully!';
                      break;
                    case 'Gender':
                      await _userService.updateGender(updatedValue);
                      providers.userR!.gender = updatedValue;
                      message = 'Gender updated successfully!';
                      break;
                    case 'Weight':
                      double weight = double.parse(updatedValue);
                      await _userService.updateWeight(weight);
                      providers.userR!.weight = weight;
                      message = 'Weight updated successfully!';
                      break;
                    case 'Height':
                      double height = double.parse(updatedValue);
                      await _userService.updateHeight(height);
                      providers.userR!.height = height;
                      message = 'Height updated successfully!';
                      break;
                    case 'User Name':
                      await _userService.updateUsername(updatedValue);
                      providers.userR!.username = updatedValue;
                      message = 'Username updated successfully!';
                      break;
                    default:
                      message = 'Unknown field: $labelText';
                  }

                  // Save changes logic here
                  print('Updated $labelText: $updatedValue');
                  Navigator.pop(context); // Close the modal sheet

                  // Show success message
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Success'),
                        content: Text(message),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } catch (e) {
                  print('Failed to update $labelText: $e');

                  // Show error message
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text(
                            'Failed to update $labelText. Please try again.'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
