import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:iconsax/iconsax.dart';
import '../controllers/foodServices.dart';
import '../models/food.dart';
import '../providers/tflite.dart';
import '../providers/userProvider.dart'; // Update the import path for tflite.dart
import 'dart:math';

class MainPageWidgets extends StatefulWidget {
  @override
  _MainPageWidgetsState createState() => _MainPageWidgetsState();
}

class _MainPageWidgetsState extends State<MainPageWidgets> {
  final TextEditingController _quantityController = TextEditingController();
  int _quantity = 1; // Initial quantity
  final FoodService _foodService = FoodService();
  List<Food> _todaysMeals = [];
  double _totalCalories = 0;
  double dailyIntake = 0;
  double _remainingCal = 0;
  File? _compressedFile;
  File? _imageFile;

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _fetchTodaysMeals();
    super.initState();
  }

  final appBar = AppBar(
    automaticallyImplyLeading: false,
    title: Container(
      alignment: Alignment.center,
      child: const Text(
        'Malay Food Calorie Tracker',
        textAlign: TextAlign.right,
      ),
    ),
  );

  Future<void> _fetchTodaysMeals() async {
    final userProvider userProviders =
        Provider.of<userProvider>(context, listen: false);
    dailyIntake = userProviders.getDailyIntake();

    final List<Food> meals =
        await _foodService.getTodaysMeals(userProviders.userR!.userId);
    double totalcalories = meals.fold(0, (sum, meal) => sum + meal.foodCal);

    setState(() {
      _todaysMeals = meals;
      _totalCalories = totalcalories;
      _remainingCal = dailyIntake - totalcalories;
    });
  }

  // just added the File() so its can be converted to the File type instead of XFile
  // need a better internet connection to test the effectiveness of compressing image quality...

  // Future<void> compress() async {
  //   var result = await FlutterImageCompress.compressAndGetFile(
  //     _imageFile!.absolute.path,
  //     _imageFile!.path + 'compressed.jpg',
  //     quality: 88,
  //   );
  //   setState(() {
  //     _compressedFile = File(result!.path);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final userProvider userProviders =
        Provider.of<userProvider>(context, listen: false);
    return Consumer<Tflite>(
      builder: (context, tflite, child) {
        return Scaffold(
          appBar: appBar,
          body: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Daily Calories',
                style: TextStyle(fontSize: 15),
              ),
              // Circular progress bar
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Card(
                  elevation: 6,
                  margin: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              '${_totalCalories.toStringAsFixed(0)}',
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'calories consumed',
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      CircularPercentIndicator(
                        radius: 55,
                        percent: min(_totalCalories / dailyIntake,
                            1.0), // Ensure the percentage doesn't exceed 1.0
                        center: Container(
                          width: 60,
                          child: Text(
                            '${_totalCalories.toStringAsFixed(0)} / ${dailyIntake.toStringAsFixed(0)}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        progressColor: _totalCalories > dailyIntake
                            ? Colors.red
                            : Colors.green, // Change color if over limit
                      ),
                      Container(
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              '${_remainingCal.toStringAsFixed(0)}',
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              'calories remaining',
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Text(
                'Recent Meal',
                style: TextStyle(fontSize: 15),
              ),

              // List of meals eaten on the day
              Container(
                width: 380,
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.5,
                child: _todaysMeals.isEmpty
                    ? const Center(
                        child: Text(
                          'No meals recorded for today',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount:
                            _todaysMeals.length, // Use foods.length directly
                        itemBuilder: (ctx, index) {
                          final Food food = _todaysMeals[
                              index]; // Access food directly from the foods list
                          return Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 5),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(food.imageUrl),
                              ),
                              title: Text(
                                food.foodName, // Use food's name from the list
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              subtitle: Text(
                                  '${food.foodCal} calories'), // Use food's calorie from the list
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
              await tflite.btnAction(ImageSource.camera);
              Navigator.of(context).pop(); // Close the loading dialog
              if (tflite.img != null) {
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String label = tflite.predLabel ?? "Label not found";
                    double confidences = tflite.confidence as double;
                    String formattedConfidence = confidences.toStringAsFixed(2);
                    return AlertDialog(
                      title: const Center(child: Text("Captured Image")),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 200,
                                height: 200,
                                child: Image.file(tflite.img!),
                              ),
                              SizedBox(height: 20),
                              Text("Label: $label"),
                              SizedBox(height: 20),
                              Text("Confidence: $formattedConfidence"),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (_quantity > 1) {
                                          _quantity--;
                                          _quantityController.text =
                                              _quantity.toString();
                                        }
                                      });
                                    },
                                    icon: Icon(Iconsax.minus),
                                  ),
                                  SizedBox(width: 5),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _quantity++;
                                        _quantityController.text =
                                            _quantity.toString();
                                      });
                                    },
                                    icon: Icon(Iconsax.add),
                                  ),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    width: 40,
                                    height: 50,
                                    child: TextField(
                                      controller: _quantityController,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          _quantity = int.tryParse(value) ?? 1;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Close"),
                        ),
                        TextButton(
                          onPressed: () {
                            // setState(() {
                            //   _imageFile = File(tflite.img!.path);
                            // });
                            // compress();
                            _foodService.saveFoodData(
                                userProviders.userR!.userId,
                                label,
                                _quantity,
                                tflite.caloriesIndex as int,
                                tflite.img!);
                            // setState(() {
                            //   _fetchTodaysMeals();
                            // });
                            //add state to refresh the widget

                            //
                            Navigator.of(context).pop();
                          },
                          child: Text("Save"),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Icon(Iconsax.camera),
          ),
        );
      },
    );
  }
}
