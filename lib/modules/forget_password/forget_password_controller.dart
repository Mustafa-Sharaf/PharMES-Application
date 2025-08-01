import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configurations/http_helpers.dart';

class ForgetPasswordController extends GetxController{
  final emailPController = TextEditingController();
  var isLoading = false.obs;
  @override
  void onClose() {
    emailPController.dispose();
    super.onClose();
  }
  Future<void> sendForgetRequest() async {
    final email = emailPController.text.trim();

    if (email.isEmpty) {
      Get.snackbar("خطأ", "يرجى إدخال البريد الإلكتروني");
      return;
    }

    isLoading.value = true;

    try {
      final response = await HttpHelper.postData(
        url: "passwordAndEmail/forgotPassword",
        body: {"email": email},
      );

      if (response.statusCode == 200) {
        Get.toNamed('/emailVerify', arguments: {'email': email});
      } else {
        final data = jsonDecode(response.body);
        print(response.body);
        print(response.statusCode);
        Get.snackbar("error", data['error'] ?? 'An error occurred');
      }
    } catch (e) {
      Get.snackbar("error", ":$e");
    } finally {
      isLoading.value = false;
    }
  }
}