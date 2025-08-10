import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import '../invoice_creator/invoice_creator_screen.dart';
import '../invoice_display/invoice_display_screen.dart';
import 'bills_controller.dart';

class BillsScreen extends StatelessWidget {
  BillsScreen({super.key});

  final BillsController controller = Get.put(BillsController());

  final List<Widget> pages = [
    InvoiceCreatorScreen(),
    InvoiceDisplayScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          "Bills Management",
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
              label: "Create a bill",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.warning_amber),
              label: "Bills",
            ),
          ],
        ),
      ),
    );
  }
}
