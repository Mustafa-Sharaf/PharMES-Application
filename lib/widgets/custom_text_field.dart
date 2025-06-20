import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Theme/theme_controller.dart';
import '../app_theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscure;
  final IconData? icon;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.obscure = false,
    this.icon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: themeController.isDarkMode.value?AppColors.white:AppColors.black,)),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF1F1F1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              cursorColor: AppColors.primaryColor,
              controller: controller,
              obscureText: obscure,
              decoration: InputDecoration(
                hintText:'Enter_your'.trParams({'field': label}),
                hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
                border: InputBorder.none,
                prefixIcon: icon != null ? Icon(icon, color: Colors.grey[700], size: 20) : null,
                suffixIcon: suffixIcon,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
