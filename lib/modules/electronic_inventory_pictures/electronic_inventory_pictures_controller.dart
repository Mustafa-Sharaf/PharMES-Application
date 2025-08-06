import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class TextRecognitionController extends GetxController {
  var image = Rx<File?>(null);
  var text = 'Taking a photo ...'.obs;

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
    text.value = _processExtractedText(rawText);

    textRecognizer.close();
  }

  String _processExtractedText(String rawText) {
    List<String> lines = rawText.split("\n").map((e) => e.trim()).toList();
    Set<String> uniqueLines = {};
    StringBuffer processedText = StringBuffer();

    for (var line in lines) {
      if (line.toLowerCase().contains("film")) continue;
      if (!uniqueLines.contains(line) && line.isNotEmpty) {
        uniqueLines.add(line);
        processedText.writeln(line);
      }
    }

    return processedText.toString().trim();
  }
}
