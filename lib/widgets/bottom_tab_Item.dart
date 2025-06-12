import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_theme/app_colors.dart';
import '../modules/home_page/home_controller.dart';


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
        onTap: () => controller.changeTabIndex(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primaryColor : Colors.grey,
              size:MediaQuery.of(context).size.width * 0.09,),
            Text(label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? AppColors.primaryColor : Colors.grey,
              ),
            ),
          ],
        ),
      );
    });
  }
}