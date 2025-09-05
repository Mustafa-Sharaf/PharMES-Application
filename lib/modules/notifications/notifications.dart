import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        title: Text(
          "Notifications".tr,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ElevatedButton(
          onPressed: () {
           /* final box = GetStorage();
            print("📦 محتويات GetStorage:");
            print(box.getKeys());
            for (var key in box.getKeys()) {
              final value = box.read(key);
              print("$key => ${value.toString()}"); // ✅ convert to String
            }*/
          },

          child: Center(child: Text("snackbar")),
      ),
    );
  }
}
