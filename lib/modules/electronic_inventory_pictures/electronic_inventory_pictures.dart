import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'electronic_inventory_pictures_controller.dart';

class TextRecognitionScreen extends StatelessWidget {
  TextRecognitionScreen({super.key});
  final controller = Get.put(TextRecognitionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Text Recognition')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Obx(() {
              return Container(
                width: double.infinity,
                height: 250,
                color: Colors.grey[300],
                child: controller.image.value != null
                    ? Image.file(controller.image.value!)
                    : const Center(child: Text("No image")),
              );
            }),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                return SingleChildScrollView(
                  child: SelectableText(
                    controller.text.value,
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
