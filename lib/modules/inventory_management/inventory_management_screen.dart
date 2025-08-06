import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import '../expired_medicines/expired_medicines_screen.dart';
import '../missing_medications/missing_medications_screen.dart';
import 'inventory_management_controller.dart';

class InventoryManagementScreen extends StatelessWidget {
  InventoryManagementScreen({super.key});

  final InventoryController controller = Get.put(InventoryController());

  final List<Widget> pages = [
    MissingMedicationsScreen(),
    ExpiredMedicinesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          "Inventory Management",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Obx(() => pages[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.grey,
          onTap: controller.changeTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.remove_circle_outline),
              label: "Missing",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.warning_amber),
              label: "Expired",
            ),
          ],
        ),
      ),
    );
  }
}
