import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../sign_in/sign_in_screen.dart';

class ResetPasswordController extends GetxController {

  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();

  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  void reset() {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPassController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar("Error", "Please fill all fields",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    Get.snackbar("Success", "Password reset successfully",
        snackPosition: SnackPosition.BOTTOM);

     Get.offAll(() => SignInScreen());
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPassController.dispose();
    super.onClose();
  }
}
