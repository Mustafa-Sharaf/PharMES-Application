import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configurations/http_helpers.dart';

class DeleteProfileController extends GetxController {

  Future<void> deleteProfile(int roleId) async {
    Get.defaultDialog(
      title: 'Are you sure to delete the account?',
      titleStyle: const TextStyle(fontSize: 18),
      content: const SizedBox.shrink(),
      cancelTextColor: Colors.red,
      textConfirm: 'Confirm',
      buttonColor: Colors.red,
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        String endpoint;
        if (roleId == 1 || roleId == 3) {
          endpoint = 'Repository/delete-profile';
        } else if (roleId == 2 || roleId == 4) {
          endpoint = 'Pharmacy/delete-profile';
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
              'the account has been deleted',
              res['data'] ?? 'deleted success',
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.white,
            );
            Get.offAllNamed('/signIn');
          } else {
            Get.back();
            Get.snackbar(
              'delete failed',
              res['message'] ,
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
