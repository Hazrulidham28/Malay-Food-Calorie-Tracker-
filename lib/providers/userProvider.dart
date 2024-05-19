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

//initializing
  userProvider() {
    _auth.authStateChanges().listen((auth.User? firebaseUser) {
      if (firebaseUser != null) {
        checkLoginStatus();
        _setLoggedInUser(firebaseUser);
      } else {
        userR = null;
        notifyListeners();
      }
    });
  }

  //check login status if authenticated or not
  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _status =
        isLoggedIn ? AuthStatus.Authenticated : AuthStatus.Unauthenticated;
    notifyListeners();
  }

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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
    } catch (e) {
      print('Error logging in: $e');
      throw e;
    }
  }

  //set logout
  Future<void> logoutUser() async {
    try {
      _auth.signOut();
      //clear current user
      userR = null;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', false);
      notifyListeners();
    } catch (e) {
      print('error logging out:$e');
      throw e;
    }
  }
}
