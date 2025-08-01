
import 'package:flutter/material.dart';
import '../app_theme/app_colors.dart';

class BuildTextFromField extends StatelessWidget {
  const BuildTextFromField({
    super.key,
    required this.text,
    required this.icon,
    this.keyboardType = TextInputType.text,
    required this.controller,
  });
  final String text;
  final IconData icon;
  final TextInputType keyboardType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: text,
          labelStyle: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          prefixIcon:  Icon(icon),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
        ),
        validator: (value) {
          final input = value?.trim() ?? '';
        /*  if (input.isEmpty) {
            return 'Please fill $text';
          }*/
          final lower = text.toLowerCase();

          if (lower.contains("name") || lower.contains("اسم")) {
            if (input.length < 3) return 'Name must be at least 3 characters long';
          }
          if (lower.contains("phone") || lower.contains("رقم")) {
            if (input.length != 10) return 'Phone number must be 10 digits';
            if (!input.startsWith('09')) return 'Phone number must start with 09';
            if (int.tryParse(input) == null) return 'Phone number must contain numbers only.';
          }
          if (lower.contains("medications") || lower.contains("دواء") || lower.contains("required")) {
            if (input.length < 5) return 'Please write the names of the required medications clearly';
          }
          return null;
        },
      ),
    );
  }
}
