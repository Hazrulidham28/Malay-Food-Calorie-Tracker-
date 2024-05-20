import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:malay_food_cal_tracker/models/food.dart';

class FoodService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> saveFoodData(String userID, String foodLabel, int quantity,
      int caloriesIndex, File foodImage) async {
    String foodID = _firestore.collection('foods').doc().id;
    try {
      // File compressedImage = await compressImage(foodImage);
      //upload food image to firebase storage
      String imageURL = await _uploadFoodImage(userID, foodImage);

      // Get current date
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      double totalCalories = getCalories(caloriesIndex, quantity);

      // Save food data to Firestore
      await _firestore.collection('food_entries').doc(foodID).set({
        'foodId': foodID,
        'userId': userID,
        'foodLabel': foodLabel,
        'quantity': quantity,
        'calories': totalCalories,
        'imageUrl': imageURL,
        'date': currentDate,
        'timestamp': FieldValue.serverTimestamp(), // For ordering purposes
      });
    } catch (e) {
      print('error saving food data:$e');
      throw e;
    }
  }

  Future<List<Food>> getTodaysMeals(String userId) async {
    final DateTime today = DateTime.now();
    final String todayString = DateFormat('yyyy-MM-dd').format(today);

    try {
      QuerySnapshot snapshot = await _firestore
          .collection('food_entries')
          .where('userId', isEqualTo: userId)
          .where('date', isEqualTo: todayString)
          .get();

      List<Food> meals = snapshot.docs.map((doc) {
        return Food(
          foodId: doc['foodId'],
          foodName: doc['foodLabel'],
          foodCal: doc['calories'],
          imageUrl: doc['imageUrl'],
        );
      }).toList();

      return meals;
    } catch (e) {
      print('Error getting today\'s meals: $e');
      throw e;
    }
  }

  //method to upload the food image to database or firebase storage
  Future<String> _uploadFoodImage(String userID, File foodImage) async {
    try {
      //create reference where the image is uploaded
      Reference ref = _storage.ref().child(
          'users/$userID/food_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      // Upload the file to Firebase Storage
      UploadTask uploadTask = ref.putFile(foodImage);
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL of the uploaded file
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading food image:$e');
      throw e;
    }
  }

  double getCalories(int indexOfcalories, int quantity) {
    double calorieofFood = 0;
    double total = 0;
    if (indexOfcalories == 0) {
      calorieofFood = 230;
    } else if (indexOfcalories == 1) {
      calorieofFood = 389;
    } else if (indexOfcalories == 2) {
      calorieofFood = 300;
    } else {
      calorieofFood = 1;
    }
    total = calorieofFood * quantity;
    return total;
  }
}
