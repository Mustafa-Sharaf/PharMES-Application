import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../app_theme/theme_controller.dart';
import '../../helpers/request_queue_manager.dart';
import '../../widgets/buildTextField.dart';
import '../home_page/medicine_content_model.dart';
import 'my_stock_controller.dart';

class AddMedicineDialog {
  final Medicine medicine;
  final MyStockController myStockController = Get.find();
  final ThemeController themeController = Get.find();

  AddMedicineDialog({required this.medicine});

  void show(BuildContext context) {
    final quantityController = TextEditingController();
    final batchController = TextEditingController();
    final purchasePriceController = TextEditingController();
    final salePriceController = TextEditingController();
    final expirationDateController = TextEditingController();

    Get.defaultDialog(
      title: 'Add_Medicine'.tr,
      titleStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      backgroundColor: themeController.isDarkMode.value?AppColors.backgroundDark :Colors.white,
      content: SingleChildScrollView(
        child: Column(
          children: [
            BuildTextField(controller: quantityController, label: "Quantity".tr, type: TextInputType.number),
            BuildTextField(controller: batchController, label: 'Batch'.tr, type: TextInputType.text),
            BuildTextField(controller: purchasePriceController, label: 'Purchase_Price'.tr, type: TextInputType.number),
            BuildTextField(controller: salePriceController, label: 'Sale_Price'.tr, type: TextInputType.number),
            BuildTextField(controller: expirationDateController, label: 'Expiration_Date_(YYYY-MM-DD)'.tr, type: TextInputType.number),
          ],
        ),
      ),
      textConfirm: 'Add'.tr,
      textCancel: 'Cancel'.tr,
      confirmTextColor: Colors.white,
      cancelTextColor: AppColors.primaryColor,
      buttonColor: AppColors.primaryColor,
      onConfirm: () async {
        final body = {
          "items": [
            {
              "medicine_id": medicine.id,
              "quantity": int.tryParse(quantityController.text) ?? 0,
              "batch": batchController.text,
              "Purchase_price": double.tryParse(purchasePriceController.text) ?? 0,
              "sale_price": double.tryParse(salePriceController.text) ?? 0,
              "expiration_date": expirationDateController.text,
            }
          ]
        };

        await RequestQueueManager.addToQueue({
          "url": "Pharmacy/pharmacy-stocks/add-medicines",
          "body": body,
        });

        Get.back();
        Get.snackbar(
          'Pending',
          'Medicine saved locally. Will sync when online.',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );


        await RequestQueueManager.processQueue();

        myStockController.fetchStocks();
      },
    );
  }
}

