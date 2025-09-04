import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configurations/http_helpers.dart';
import '../../app_theme/app_colors.dart';

class LogOutController extends GetxController {

  LogOutController();

  Future<void> logout(int roleId) async {
    Get.defaultDialog(
      title: 'Are_you_sure_to_log_out'.tr,
      titleStyle: const TextStyle(fontSize: 18),
      content: const SizedBox.shrink(),
      cancelTextColor: AppColors.primaryColor,
      textConfirm: 'Confirm'.tr,
      buttonColor: AppColors.primaryColor,
      textCancel: 'Cancel'.tr,
      confirmTextColor: Colors.white,
      onConfirm: () async {
        String endpoint;
        if (roleId == 1 || roleId == 3) {
          endpoint = 'Repository/logout';
        } else if (roleId == 2 || roleId == 4) {
          endpoint = 'Pharmacy/logout';
        } else {
          Get.back();
          Get.snackbar(
            'Role Error',
            'Invalid role ID',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.orange,
            colorText: Colors.white,
          );
          return;
        }
        try {
          final response = await HttpHelper.postData(
            url: endpoint,
          );

          final res = jsonDecode(response.body);

          if (response.statusCode == 200 || response.statusCode == 201) {
            Get.back();
            Get.snackbar(
              'Signed out',
              res['data'] ?? 'Logout successful',
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
            );
            Get.offAllNamed('/signIn');
          } else {
            Get.back();
            Get.snackbar(
              'Logout failed',
              res['message'] ?? 'An error occurred',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        } catch (e) {
          Get.back();
          Get.snackbar(
            'Error',
            'Something went wrong',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
      onCancel: () {
        Get.back();
      },
    );
  }
}
