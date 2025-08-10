import 'package:flutter/material.dart';

import '../app_theme/app_colors.dart';

class RoundedTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final int? maxLength;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final bool showCounter;

  const RoundedTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.padding,
    this.height,
    this.showCounter = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          counterText: showCounter ? null : '',
        ),
        onChanged: onChanged,
        keyboardType: keyboardType,
        maxLength: maxLength,
      ),
    );
  }
}
