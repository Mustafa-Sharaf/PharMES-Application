import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_theme/app_colors.dart';
import '../app_theme/theme_controller.dart';



class BuildTextField extends StatelessWidget {
  const BuildTextField({super.key,required this.controller,required this.type,required this.label});

  final String label;
  final TextInputType type;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.primaryColor),
          filled: true,
          fillColor: themeController.isDarkMode.value?AppColors.componentDark :Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
      ),
    );
  }
}

