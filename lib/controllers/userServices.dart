import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class userService {
  // Singleton pattern
  static final userService _instance = userService._internal();
  factory userService() => _instance;
  userService._internal();

  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> _updateUserField(String field, dynamic value) async {
    try {
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({field: value});
      }
    } catch (error) {
      print("Error updating $field: $error");
      // Consider using a logging package or rethrowing the error
    }
  }

  Future<void> updateUsername(String username) async {
    await _updateUserField('username', username);
  }

  Future<void> updateActivity(String activity) async {
    await _updateUserField('activityLevel', activity);
  }

  Future<void> updateAge(int age) async {
    await _updateUserField('age', age);
  }

  Future<void> updateWeight(double weight) async {
    await _updateUserField('weight', weight);
  }

  Future<void> updateGender(String gender) async {
    await _updateUserField('gender', gender);
  }

  Future<void> updateHeight(double height) async {
    await _updateUserField('height', height);
  }

  Future<void> updateProfilePhoto(String photoLink) async {
    await _updateUserField('userProfile', photoLink);
  }
}
