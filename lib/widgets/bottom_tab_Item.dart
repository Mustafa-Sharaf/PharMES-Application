import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_theme/app_colors.dart';
import '../modules/bills/bills_screen.dart';
import '../modules/cart/cart_screen.dart';
import '../modules/home_page/home_controller.dart';
import '../modules/inventory_management/inventory_management_screen.dart';


class BottomTabItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final BottomNavController controller = Get.find();

  BottomTabItem({
    super.key,
    required this.index,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.currentIndex.value == index;
      return GestureDetector(
        onTap: (){
            if (index == 1) {
              Get.to(() => const InventoryManagementScreen());
            } else if (index == 3) {
              Get.to(() => const CartScreen());
            } else if (index == 4) {
              Get.to(() => const BillsScreen());
            } else {
              controller.changeTabIndex(index);
            }
          },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primaryColor : Colors.grey,
              size:MediaQuery.of(context).size.width * 0.06,),
            Text(label,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? AppColors.primaryColor : Colors.grey,
              ),
            ),
          ],
        ),
      );
    });
  }
}