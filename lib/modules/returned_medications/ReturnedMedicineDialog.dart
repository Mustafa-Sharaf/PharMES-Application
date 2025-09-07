
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';
import '../../../configurations/http_helpers.dart';
import '../../../widgets/buildTextField.dart';
import '../home_page/medicine_content_model.dart';
import '../my_stock/my_stock_controller.dart';



class ReturnedMedicineDialog{


  final Medicine medicine;
  final MyStockController myStockController = Get.find();

  ReturnedMedicineDialog({required this.medicine});

  void show(BuildContext context) {
    final quantityController = TextEditingController();
    final batchController = TextEditingController();
    final purchasePriceController = TextEditingController();
    final salePriceController = TextEditingController();
    final expirationDateController = TextEditingController();

    Get.defaultDialog(
      title: 'Add Medicine',
      titleStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        child: Column(
          children: [
            BuildTextField(controller: quantityController, label:  "Quantity",type:TextInputType.number),
            BuildTextField(controller:batchController, label: 'Batch',type:  TextInputType.text),
            BuildTextField(controller:purchasePriceController, label: 'Purchase Price',type:  TextInputType.number),
            BuildTextField(controller:salePriceController,label:  'Sale Price',type:  TextInputType.number),
            BuildTextField(controller:expirationDateController,label:  'Expiration Date (YYYY-MM-DD)',type:  TextInputType.number),
          ],
        ),
      ),
      textConfirm: 'Add',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      cancelTextColor: AppColors.primaryColor,
      buttonColor: AppColors.primaryColor,
      onConfirm: () async {
        final body = {
              "medicine_id": medicine.id,
              "quantity": int.tryParse(quantityController.text) ?? 0,
              "batch": batchController.text,
              "Purchase_price": double.tryParse(purchasePriceController.text) ?? 0,
              "sale_price": double.tryParse(salePriceController.text) ?? 0,
              "expiration_date": expirationDateController.text,
        };

        final res = await HttpHelper.postJson(
          url: 'Pharmacy/pharmacy-stocks/returned_medicine',
          body: body,
        );

        if (res.statusCode == 200 || res.statusCode == 201) {
          Get.back();
          Get.snackbar('Success', 'Medicine added to stock',
              backgroundColor: Colors.green, colorText: Colors.white);
          myStockController.fetchStocks();
        } else {
          Get.snackbar('Error', 'Failed to add medicine',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      },
    );
  }
}