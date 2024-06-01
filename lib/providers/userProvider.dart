import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

enum AuthStatus { Authenticated, Unauthenticated }

class userProvider extends ChangeNotifier {
  User? userR;
  User? get user => userR;

  AuthStatus _status = AuthStatus.Unauthenticated;
  AuthStatus get status => _status;

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Initializing
  userProvider() {
    _auth.authStateChanges().listen((auth.User? firebaseUser) {
      if (firebaseUser != null) {
        _setLoggedInUser(firebaseUser);
      } else {
        userR = null;
        _status = AuthStatus.Unauthenticated;
        notifyListeners();
      }
    });
  }

  // Check login status if authenticated or not
  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _status =
        isLoggedIn ? AuthStatus.Authenticated : AuthStatus.Unauthenticated;
    notifyListeners();
  }

  // Set logged in user
  Future<void> _setLoggedInUser(auth.User firebaseUser) async {
    DocumentSnapshot userSnapshot =
        await _firestore.collection('users').doc(firebaseUser.uid).get();

    if (userSnapshot.exists) {
      userR = User.fromMap(userSnapshot.data() as Map<String, dynamic>);
      _status = AuthStatus.Authenticated;
      notifyListeners();
    } else {
      userR = null;
      _status = AuthStatus.Unauthenticated;
      notifyListeners();
    }
  }

  // Set user photo (implementation needed)
  Future<void> setUserphoto() async {}

  void setUser(User thisUser) {
    userR = thisUser;
    notifyListeners();
  }

  Future<void> registerUser() async {
    try {
      // Register the user with email and password
      auth.UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: userR!.email,
        password: userR!.password,
      );

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

  // Login the user
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      auth.UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);

      await _setLoggedInUser(userCredential.user!);
      await checkLoginStatus();
    } catch (e) {
      print('Error logging in: $e');
      throw e;
    }
  }

  // Logout the user
  Future<void> logoutUser() async {
    try {
      await _auth.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', false);

      userR = null;
      _status = AuthStatus.Unauthenticated;
      notifyListeners();
    } catch (e) {
      print('Error logging out: $e');
      throw e;
    }
  }

  double getDailyIntake() {
    double BMR = 0;

    if (userR!.gender.toLowerCase() == 'male') {
      BMR = 88.362 +
          (13.397 * user!.weight) +
          (4.799 * user!.height) -
          (5.677 * user!.age);
    } else {
      BMR = 447.593 +
          (9.247 * user!.weight) +
          (3.098 * user!.height) -
          (4.330 * user!.age);
    }

    double activityFactor = 0;
    double dailyIntake = 0;

    switch (userR!.activityLevel.toLowerCase()) {
      case 'sedentary':
        activityFactor = 1.2;
        break;
      case 'lightly active':
        activityFactor = 1.375;
        break;
      case 'moderately active':
        activityFactor = 1.55;
        break;
      case 'very active':
        activityFactor = 1.725;
        break;
      case 'extra active':
        activityFactor = 1.9;
        break;
      default:
        activityFactor = 1.2;
    }

    dailyIntake = BMR * activityFactor;
    return dailyIntake;
  }

  String getBmi() {
    String Bmilevel = "Unknown";
    double Bmi;

    Bmi = (userR!.weight / ((userR!.height / 100) * (userR!.height / 100)));

    if (Bmi < 18.5) {
      Bmilevel = "Underweight";
    } else if (Bmi >= 18.5 && Bmi < 24.9) {
      Bmilevel = "Normal";
    } else if (Bmi >= 25 && Bmi < 29.9) {
      Bmilevel = "Overweight";
    } else {
      Bmilevel = "Obesity";
    }

    return Bmilevel;
  }
}
