import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as imglib;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class Tflite extends ChangeNotifier {
  //late final WebViewController controller;
  var loadingPercentage = 0;
  File? img;
  String? predLabel;
  List result = [];
  bool isLoading = false;
  XFile? imagePicked;
  List<String> allLabel = [];
  Interpreter? interpreterInstance;
  double? confidence;
  int? caloriesIndex;

  Tflite() {
    loadAsset();
  }

  void loadAsset() async {
    String loadedString = await rootBundle.loadString('assets/label6model.txt');
    allLabel = loadedString.split('\n');
    notifyListeners();
  }

  // int calories = 0;

  // void calculateCalorie() {
  //   if (predLabel == 'karipap') {
  //     calories = 130;
  //   } else if (predLabel == 'roti_canai') {
  //     calories = 300;
  //   } else if (predLabel == 'nasi_lemak') {
  //     calories = 389;
  //   } else {
  //     calories = 1; // Default calorie value if label doesn't match
  //   }
  // }

  Future<Interpreter> get _interpreter async {
    if (interpreterInstance == null) {
      interpreterInstance = await Interpreter.fromAsset(
        'assets/resnet50_model6.tflite',
      );
      notifyListeners();
    }
    return interpreterInstance!;
  }

  Future predict(imglib.Image img) async {
    isLoading = true;
    notifyListeners();

    final imageInput = imglib.copyResize(img, width: 180, height: 180);

    final imageMatrix = List.generate(
      imageInput.height,
      (y) => List.generate(
        imageInput.width,
        (x) {
          final pixel = imageInput.getPixel(x, y);
          return [pixel.r, pixel.g, pixel.b];
        },
      ),
    );

    result = await _runInference(imageMatrix);
    predLabel = getLabel(result.cast<num>()).toString();
    confidence = getConfidence(result.cast<num>());
    isLoading = false;
    // calculateCalorie();
    notifyListeners();
  }

  Future<List<num>> _runInference(
    List<List<List<num>>> imageMatrix,
  ) async {
    final interpreter = await _interpreter;
    final input = [imageMatrix];
    final output = List.filled(1 * allLabel.length, 0.0).reshape(
      [1, allLabel.length],
    );
    // final output = List<int>.filled(1 * 3, 0).reshape([1, 3]);

    interpreter.run(input, output);
    notifyListeners();
    return output.first;
  }

  String getLabel(List<num>? diagnoseScores) {
    int bestInd = 0;
    num maxScore = -1;

    diagnoseScores?.asMap().forEach((i, score) {
      if (score > maxScore) {
        maxScore = score;
        bestInd = i;
      }
    });

    return allLabel[bestInd];
  }

  void setLabelConfidence() {
    // Check if confidence is null and assign a default value if necessary
    double thisConfidence = confidence ?? 0;

    if (caloriesIndex == 1 && caloriesIndex == 2 && caloriesIndex == 5) {
      confidence = 0;
    } else {
      if (thisConfidence < 0.70) {
        predLabel = 'Not Learn yet';
        confidence = 0;
      } else {}
    }
  }

  double getConfidence(List<num>? diagnoseScores) {
    int bestInd = 0;
    num maxScore = -1;

    diagnoseScores?.asMap().forEach((i, score) {
      if (score > maxScore) {
        maxScore = score;
        bestInd = i;
      }
    });

    caloriesIndex = bestInd;

    return maxScore as double;
  }

  Future getImage(ImageSource source) async {
    imagePicked = await ImagePicker().pickImage(source: source);
    if (imagePicked != null) {
      img = File(imagePicked!.path);
      notifyListeners();
      await predict(imglib.decodeImage(File(img!.path).readAsBytesSync())!);
    }
  }

  Future btnAction(ImageSource source) async {
    await getImage(source);
    notifyListeners();
  }

  void refreshPages() {
    notifyListeners();
  }
}
