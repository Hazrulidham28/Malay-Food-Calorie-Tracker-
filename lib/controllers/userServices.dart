import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class userService {
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> updateUsername(String uname) async {
    try {
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({'username': uname});
      }
    } catch (error) {
      print("Error changing username: $error");
    }
  }

  Future<void> updateActivity(String activity) async {
    try {
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({'activityLevel': activity});
      }
    } catch (error) {
      print("Error UpdateActivity: $error");
    }
  }

  Future<void> updateAge(int age) async {
    try {
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({'age': age});
      }
    } catch (error) {
      print("Error UpdateAge: $error");
    }
  }

  Future<void> updateWeight(double weight) async {
    try {
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({'weight': weight});
      }
    } catch (error) {
      print("Error Updateweight: $error");
    }
  }

  Future<void> updateGender(String gender) async {
    try {
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({'gender': gender});
      }
    } catch (error) {
      print("Error Updategender: $error");
    }
  }

  Future<void> updateHeight(double height) async {
    try {
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({'height': height});
      }
    } catch (error) {
      print("Error Updategender: $error");
    }
  }

  Future<void> updatePPhoto(String photolink) async {
    try {
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({'userProfile': photolink});
      }
    } catch (error) {
      print("Error UpdateProfilPhoto: $error");
    }
  }
}
