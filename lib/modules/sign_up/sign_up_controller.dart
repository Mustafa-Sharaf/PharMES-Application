// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
//
// class SignUpController extends GetxController {
//   String? selectedRole;
//
//   final nameController = TextEditingController();
//   final phoneController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   final storeNameController = TextEditingController();
//   final storeAddressController = TextEditingController();
//
//   var obscurePassword = true.obs;
//   var obscureConfirm = true.obs;
//
//   final roles = [
//     'Repository Owner',
//     'Pharmacy Owner',
//     'Pharmacist',
//     'Employee',
//   ];
//
//   void togglePasswordVisibility() {
//     obscurePassword.value = !obscurePassword.value;
//   }
//
//   void toggleConfirmVisibility() {
//     obscureConfirm.value = !obscureConfirm.value;
//   }
//
//   void setSelectedRole(String? value) {
//     selectedRole = value;
//     update();
//   }
//
//   void signUp() {
//     // TODO: Implement sign up logic
//   }
//
//   @override
//   void onClose() {
//     nameController.dispose();
//     phoneController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     storeNameController.dispose();
//     storeAddressController.dispose();
//     super.onClose();
//   }
// }
