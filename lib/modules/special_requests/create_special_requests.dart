import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/modules/special_requests/special_requests_controller.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/build_textFromField.dart';

class CreateSpecialRequests extends StatelessWidget {
  CreateSpecialRequests({super.key});

  final controller = Get.find<SpecialRequestsController>();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        title: const Text(
          "Create Special Request",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            BuildTextFromField(
              text: "Name",
              icon: Icons.person,
              keyboardType: TextInputType.text,
              controller: controller.nameController,
            ),
            BuildTextFromField(
              text: "Required Medications",
              icon: Icons.medication,
              keyboardType: TextInputType.text,
              controller: controller.medsController,
            ),
            BuildTextFromField(
              text: "Total Price",
              icon: Icons.price_check,
              keyboardType: TextInputType.number,
              controller: controller.totalController,
            ),
            BuildTextFromField(
              text: "Phone",
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
              controller: controller.phoneController,
            ),
            BuildTextFromField(
              text: "Amount Paid",
              icon: Icons.payments,
              keyboardType: TextInputType.number,
              controller: controller.paidController,
            ),
            BuildTextFromField(
              text: "Remaining",
              icon: Icons.account_balance_wallet,
              keyboardType: TextInputType.number,
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
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    controller.createRequest();
                  }
                },
                child: const Text(
                  "Create",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
