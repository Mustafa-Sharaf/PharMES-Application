import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/build_flexible.dart';
import 'electronic_inventory_pictures_controller.dart';

class TextRecognitionScreen extends StatelessWidget {
  TextRecognitionScreen({super.key});
  final controller = Get.put(TextRecognitionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inventory_by_Pictures'.tr,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.055,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
      ),
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
                    : Center(child: Text("No image".tr)),
              );
            }),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.matchedStocks.isEmpty) {
                  return Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(8),
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SelectableText(
                        controller.text.value,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: controller.matchedStocks.length,
                  itemBuilder: (context, index) {
                    final stock = controller.matchedStocks[index];
                    final medicine = stock['medicine'] as Map<String, dynamic>? ?? {};
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.medication,
                            color: AppColors.primaryColor,
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  BuildFlexible(
                                    title: "Trade_name".tr,
                                    text: medicine['trade_name'] ?? '',
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  BuildFlexible(
                                    title: "Titer".tr,
                                    text: medicine['titer'] ?? '',
                                  ),
                                ],
                              ),
                            ],
                          ),
                          subtitle: Text(
                            //'Quantity:'.trParams({'quantity': stock['quantity'] ?? ''}),
                            "Quantity: ${stock['quantity'] ?? ''}",
                            style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.width * 0.045,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
