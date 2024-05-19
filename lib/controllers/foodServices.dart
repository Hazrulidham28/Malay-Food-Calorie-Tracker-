import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class FoodService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> saveFoodData(String userID, String foodLabel, int quantity,
      double totalCal, File foodImage) async {
    String foodID = FirebaseFirestore.instance.collection('foods').doc().id;
    try {
      //upload food image to firebase storage
      String imageURL = await _uploadFoodImage(userID, foodImage);

      // Get current date
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      // Save food data to Firestore
      await _firestore.collection('food_entries').doc(foodID).set({
        'foodId': foodID,
        'userId': userID,
        'foodLabel': foodLabel,
        'quantity': quantity,
        'calories': totalCal,
        'imageUrl': imageURL,
        'date': currentDate,
        'timestamp': FieldValue.serverTimestamp(), // For ordering purposes
      });
    } catch (e) {
      print('error saving food data:$e');
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

  // double totalCalories(String label, int quantity) {
  //   //food calories for nasi lemak, roti canai and karipap
  //   double foodCal = 0;
  //   double totalCalorie = 0;

  //   // Karipap = 130 calories
  //   // nasi_lemak = 389 calories
  //   // roti_canai = 300 calories

  //   // String lowercaseLabel = label.toLowerCase();
  //   // print('Label received: $label');
  //   // print('Lowercase label: $lowercaseLabel');

  //   // if (lowercaseLabel == 'karipap') {
  //   //   foodCal = 130;
  //   // } else if (lowercaseLabel == 'roti_canai') {
  //   //   foodCal = 300;
  //   // } else if (lowercaseLabel == 'nasi_lemak') {
  //   //   foodCal = 389;
  //   // } else {
  //   //   foodCal = 1; // Default calorie value if label doesn't match
  //   // }
  //   // Map of food labels to their respective calorie values

  //   Map<String, double> foodCalories = {
  //     'karipap': 130,
  //     'nasi_lemak': 389,
  //     'roti_canai': 300,
  //   };

  //   // Convert label to lowercase for case-insensitive comparison
  //   String lowercaseLabel = label.toLowerCase();
  //   print('Label received: $label');
  //   print('Lowercase label: $lowercaseLabel');

  //   // Get the calorie value from the map or default to 1 if not found
  //   foodCal = foodCalories[lowercaseLabel] ?? 1;

  //   totalCalorie = foodCal * (quantity);
  //   print('Calculated foodCal: $foodCal');
  //   print('Total calorie: $totalCalorie');

  //   return totalCalorie;
  // }
}
