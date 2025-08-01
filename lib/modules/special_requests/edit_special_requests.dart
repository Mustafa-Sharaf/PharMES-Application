import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/modules/special_requests/special_requests_controller.dart';
import 'package:pharmes_app/modules/special_requests/special_requests_model.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/build_textFromField.dart';

class EditSpecialRequests extends StatelessWidget {
  EditSpecialRequests({super.key});

  final controller = Get.find<SpecialRequestsController>();

  @override
  Widget build(BuildContext context) {
    final SpecialRequestModel model = Get.arguments;
    controller.fillForm(model);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        title: const Text(
          "Edit Special Request",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          BuildTextFromField(
            text: "Name",
            icon: Icons.person,
            controller: controller.nameController,
          ),
          BuildTextFromField(
            text: "Required Medications",
            icon: Icons.medication,
            controller: controller.medsController,
          ),
          BuildTextFromField(
            text: "Total Price",
            icon: Icons.price_check,
            controller: controller.totalController,
          ),
          BuildTextFromField(
            text: "Phone",
            icon: Icons.phone,
            controller: controller.phoneController,
          ),
          BuildTextFromField(
            text: "Amount Paid",
            icon: Icons.payments,
            controller: controller.paidController,
          ),
          BuildTextFromField(
            text: "Remaining",
            icon: Icons.account_balance_wallet,
            controller: controller.remainingController,
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                fixedSize: const Size(100, 30),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => controller.updateRequest(model.id),
              child: const Text("Update", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
