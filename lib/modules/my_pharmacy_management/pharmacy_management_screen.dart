import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pharmes_app/modules/my_pharmacy_management/pharmacy_management_controller.dart';

import '../../app_theme/app_colors.dart';

class PharmacyManagementScreen extends StatelessWidget {
  PharmacyManagementScreen({super.key});

  final ButtonController buttonController = Get.put(ButtonController());
  final GetStorage _box = GetStorage();
  @override
  Widget build(BuildContext context) {
    int role = _box.read('role_id') ?? 0;
    String titleText = 'My Pharmacy Management';
    if (role == 1) {
      titleText = 'My Pharmacy Repository';
    } else if (role == 3) {
      titleText = 'My Pharmacy Management';
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(titleText,
            style: const TextStyle(fontSize: 18, color: Colors.white)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Obx(() {
            final isPressed = buttonController.isPressed.value;

            return GestureDetector(
              onTap: buttonController.pressButton,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 75,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isPressed ? AppColors.primaryColor : AppColors.white,
                  borderRadius: BorderRadius.circular(isPressed ? 75 : 16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      LucideIcons.settings,
                      color: isPressed ? Colors.white : AppColors.primaryColor,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Determine Permissions',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isPressed ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}