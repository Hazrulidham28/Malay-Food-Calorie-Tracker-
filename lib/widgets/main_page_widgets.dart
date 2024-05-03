import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:iconsax/iconsax.dart';
import '../models/food.dart';
import '../providers/tflite.dart'; // Update the import path for tflite.dart

class MainPageWidgets extends StatefulWidget {
  @override
  _MainPageWidgetsState createState() => _MainPageWidgetsState();
}

class _MainPageWidgetsState extends State<MainPageWidgets> {
  final TextEditingController _quantityController = TextEditingController();
  int _quantity = 1; // Initial quantity

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  final appBar = AppBar(
    automaticallyImplyLeading: false,
    title: Container(
      alignment: Alignment.center,
      child: Text(
        'Malay Food Calorie Tracker',
        textAlign: TextAlign.right,
      ),
    ),
  );

  List<Food> foods = [
    Food(
        foodId: '1',
        foodName: 'Nasi Lemak',
        foodCal: 52,
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/Nasi_Lemak_dengan_Chili_Nasi_Lemak_dan_Sotong_Pedas%2C_di_Penang_Summer_Restaurant.jpg/375px-Nasi_Lemak_dengan_Chili_Nasi_Lemak_dan_Sotong_Pedas%2C_di_Penang_Summer_Restaurant.jpg'),
    Food(
        foodId: '2',
        foodName: 'Roti Canai',
        foodCal: 105,
        imageUrl:
            'https://www.elmundoeats.com/wp-content/uploads/2017/11/Roti-Canai-3.jpg'),
    Food(
        foodId: '3',
        foodName: 'Ayam Goreng',
        foodCal: 165,
        imageUrl:
            'https://www.yummytummyaarthi.com/wp-content/uploads/2023/08/1-scaled-1.jpeg'),
    Food(
        foodId: '4',
        foodName: 'Broccoli',
        foodCal: 55,
        imageUrl:
            'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTyN7CNzcBzQLqrMiGwOU1etbewP-Hlaz4_pjBSxQYoAuWseWo7'),
    Food(
        foodId: '5',
        foodName: 'Satay',
        foodCal: 280,
        imageUrl:
            'https://www.ajinomotofoodbizpartner.com.my/wp-content/uploads/2023/11/Satay-mobile-02-jpg.webp'),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<Tflite>(
      builder: (context, tflite, child) {
        return Scaffold(
          appBar: appBar,
          body: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
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
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              '1200',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'calories consumed',
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      CircularPercentIndicator(
                        radius: 55,
                        percent: 0.51,
                        center: Container(
                          width: 60,
                          child: Text(
                            '1200 / 2000 ',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        progressColor: Colors.green,
                      ),
                      Container(
                        width: 100,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              '800',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            Text(
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
              Text(
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
                child: ListView.builder(
                  itemCount: foods.length, // Use foods.length directly
                  itemBuilder: (ctx, index) {
                    final Food food = foods[
                        index]; // Access food directly from the foods list
                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
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
                            '${food.foodCal} Calories'), // Use food's calorie from the list
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
                  return Center(
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
                    return AlertDialog(
                      title: Text("Captured Image"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            child: Image.file(tflite.img!),
                          ),
                          SizedBox(height: 20),
                          Text("Label: $label"),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                              SizedBox(width: 10),
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
                                width: 50,
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
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Close"),
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
