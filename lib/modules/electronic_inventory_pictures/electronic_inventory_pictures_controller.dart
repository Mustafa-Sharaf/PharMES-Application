import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import '../my_stock/my_stock_controller.dart';

class TextRecognitionController extends GetxController {
  var image = Rx<File?>(null);
  var text = 'Taking a photo ...'.obs;
  var matchedStocks = <Map<String, dynamic>>[].obs;

  final MyStockController stockController = Get.find();

  @override
  void onInit() {
    super.onInit();
    pickImage(ImageSource.camera);
  }

  Future pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) {
        text.value = 'No image selected';
        return;
      }

      image.value = File(pickedImage.path);
      text.value = 'Text recognition...';

      await _textRecognition(image.value!);
    } catch (e) {
      text.value = 'An error occurred while selecting an image';
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future _textRecognition(File img) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final inputImage = InputImage.fromFilePath(img.path);
    final recognizedText = await textRecognizer.processImage(inputImage);

    String rawText = recognizedText.text;
    List<String> extractedNames = _processExtractedText(rawText);

    _searchInStock(extractedNames);

    textRecognizer.close();
  }

  List<String> _processExtractedText(String rawText) {
    List<String> lines = rawText.split("\n").map((e) => e.trim()).toList();
    Set<String> uniqueLines = {};
    List<String> result = [];

    for (var line in lines) {
      final lowerLine = line.toLowerCase();
      if (lowerLine.contains("film") ||
          lowerLine.contains("tablets") ||
          lowerLine.contains("hours") ||
          lowerLine.contains("capsules") ||
          lowerLine.contains("for adults") ||
          lowerLine.contains("suppositories") ||
          lowerLine.contains("comprimés") ||
          lowerLine.contains("lot") ||
          lowerLine.contains("mfg") ||
          lowerLine.contains("exp")) continue;

      if (RegExp(r'^\d+$').hasMatch(line)) continue;

      String modifiedLine = line.replaceAllMapped(
        RegExp(r'(\b\w+\b)?\s*(\d+)\s*mg', caseSensitive: false),
            (match) {
          final word = match.group(1);
          return word ?? '';
        },
      ).trim();

      if (modifiedLine.isNotEmpty && !uniqueLines.contains(modifiedLine)) {
        uniqueLines.add(modifiedLine);
        result.add(modifiedLine);
      }
    }

    return result;
  }

  void _searchInStock(List<String> extractedNames) {
    matchedStocks.clear();

    for (var name in extractedNames) {
      for (var stock in stockController.stocks) {
        final medicine = stock['medicine'] as Map<String, dynamic>? ?? {};
        final tradeName = (medicine['trade_name'] ?? '').toString().toLowerCase();

        if (tradeName.contains(name.toLowerCase())) {
          matchedStocks.add(stock);
        }
      }
    }

    if (matchedStocks.isEmpty) {
      text.value = "No matching medicines found in stock";
    } else {
      text.value = "Found ${matchedStocks.length} medicines";
    }
  }
}
