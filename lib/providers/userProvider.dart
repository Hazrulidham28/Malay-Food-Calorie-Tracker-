import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class userProvider extends ChangeNotifier {
  // late User _user;
  // User get user => _user;
  User? userR;

  User? get user => userR;

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // userProvider() {
  //   _auth.authStateChanges().listen((auth.User? firebaseUser) {
  //     if (firebaseUser != null) {
  //       _setLoggedInUser(firebaseUser);
  //     } else {
  //       userR = null;
  //       notifyListeners();
  //     }
  //   });
  // }

  //set loggedinuser
  void _setLoggedInUser(auth.User? firebaseUser) async {
    if (firebaseUser != null) {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('users').doc(firebaseUser.uid).get();

      userR = User.fromMap(userSnapshot.data() as Map<String, dynamic>);
      notifyListeners();
    }
  }

  void setUser(User thisUser) {
    userR = thisUser;
  }

  //register user
  // Future<void> registerUser({
  //   required String username,
  //   required String email,
  //   required String password,
  //   required double weight,
  //   required double height,
  //   required int age,
  //   required String activityLevel,
  //   required String userProfile,
  // }) async {
  //   try {
  //     auth.UserCredential userCredential =
  //         await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     _user = User(
  //       userId: userCredential.user!.uid,
  //       username: username,
  //       email: email,
  //       weight: weight,
  //       height: height,
  //       age: age,
  //       activityLevel: activityLevel,
  //       userProfile: userProfile,
  //     );

  //     await _firestore.collection('users').doc(_user.userId).set(_user.toMap());

  //     notifyListeners();
  //   } catch (e) {
  //     print('Error registering user: $e');
  //     throw e;
  //   }
  // }

  Future<void> registerUser() async {
    try {
      // Register the user with email and password
      auth.UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: userR!.email, password: userR!.password);

      // Update the user ID in the regUser instance
      userR!.userId = userCredential.user!.uid;

      // Save the user data to Firestore
      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userR!.toMap());

      // Notify listeners after completing the registration
      notifyListeners();
    } catch (e) {
      // Print the actual error message for debugging
      print('Error in registration: $e');
    }
  }

  //login the user
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Error logging in: $e');
      throw e;
    }
  }

  //set logout
  void logoutUser() {
    _auth.signOut();
  }
}
