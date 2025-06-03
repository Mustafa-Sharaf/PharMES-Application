import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final storeNameController = TextEditingController();
  final storeAddressController = TextEditingController();
  final storePhoneController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  String? selectedRole;

  List<String> roles = [
    'Pharmacy Owner',
    'Repository Owner',
    'Pharmacist',
    'RepositoryEmployee',
  ];

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    update();
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    update();
  }

  void changeRole(String? role) {
    selectedRole = role;
    update();
  }

  void signUp() {

  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    storeNameController.dispose();
    storeAddressController.dispose();
    super.onClose();
  }
}
