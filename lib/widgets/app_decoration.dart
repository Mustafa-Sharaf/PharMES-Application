import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Theme/theme_controller.dart';
import '../app_theme/app_colors.dart';

class AppDecorations {
  static InputDecoration customInputDecoration(String label, double width, double height) {
    final ThemeController themeController = Get.find();
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: themeController.isDarkMode.value?Colors.grey:Colors.grey.shade600 , fontSize: 17),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.025),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
//e

