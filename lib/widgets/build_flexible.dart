import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_theme/app_colors.dart';
import '../app_theme/theme_controller.dart';

class BuildFlexible extends StatelessWidget {
  const BuildFlexible({super.key, required this.title, required this.text});
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    return Flexible(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: themeController.isDarkMode.value?AppColors.white :Colors.black,
              ),
            ),
            TextSpan(
              text: text,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 14,
                color: themeController.isDarkMode.value?AppColors.background :AppColors.DarkGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
