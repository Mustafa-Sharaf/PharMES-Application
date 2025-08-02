import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configurations/http_helpers.dart';
import '../sign_in/sign_in_screen.dart';

class ResetPasswordController extends GetxController {

  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();

  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;

  late String email;

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  Future<void> reset() async {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPassController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    try {
      final response = await HttpHelper.postData(
        url: "passwordAndEmail/resetPassword",
        body: {
          "email": email,
          "password": password,
          "password_confirmation": confirmPassword
        },
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar("Success", data['message']);
        Get.to(() => SignInScreen());


      } else {
        print(response.body);
        Get.snackbar("Error", data['message']);
      }
    } catch (e) {
      Get.snackbar("Error", "Server error: $e");
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPassController.dispose();
    super.onClose();
  }
}
