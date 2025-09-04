import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_theme/app_colors.dart';
import '../app_theme/theme_controller.dart';

class BuildPharmacyManagement extends StatelessWidget {
  const BuildPharmacyManagement({
    super.key,
    required this.text,
    required this.icon,
    required this.pathName,
  });
  final String text;
  final IconData icon;
  final String pathName;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    return GestureDetector(
      onTap: () => Get.toNamed(pathName),
      child: Padding(
        padding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.03,
          left: MediaQuery.of(context).size.width * 0.03,
          top: MediaQuery.of(context).size.width * 0.02,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
            color: themeController.isDarkMode.value?AppColors.componentDark :Colors.grey[500]!.withOpacity(0.16),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Icon(icon, size:  MediaQuery.of(context).size.width * 0.05, color: Color(0xFF2C5FE0)),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Text(
                text,
                style: TextStyle(fontSize:  MediaQuery.of(context).size.width * 0.048, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
