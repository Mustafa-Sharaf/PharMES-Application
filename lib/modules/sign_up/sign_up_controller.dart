import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../app_theme/app_colors.dart';
import '../../configurations/http_helpers.dart';

class SignUpController extends GetxController {
  String? token;
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
    'Pharmacy_Owner'.tr,
    'Repository_Owner'.tr,
    'Pharmacist'.tr,
    'RepositoryEmployee'.tr,
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

  signUp(BuildContext context) async {
    String name = nameController.text;
    String phone = phoneController.text;
    String email = emailController.text.trim();
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;


    if (name.isEmpty || phone.isEmpty ||email.isEmpty || password.isEmpty || confirmPassword.isEmpty|| selectedRole==null) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      Get.snackbar(
        'Error',
        'Please enter a valid email address',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (password.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    Map<String, dynamic> data = {
      'name': name,
      'phone_number': phone,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
    };

    String endpoint = '';

    switch (selectedRole) {
      case 'Pharmacy Owner':
        if (storeNameController.text.isEmpty || storeAddressController.text.isEmpty || storePhoneController.text.isEmpty) {
          Get.snackbar('Error', 'Please fill in pharmacy details', backgroundColor: Colors.red, colorText: Colors.white);
          return;
        }
        data.addAll({
          'pharmacy_name': storeNameController.text,
          'pharmacy_address': storeAddressController.text,
          'pharmacy_phone': storePhoneController.text,
        });
        endpoint = 'Pharmacy/owner-register';
        break;

      case 'Repository Owner':
        if (storeNameController.text.isEmpty || storeAddressController.text.isEmpty || storePhoneController.text.isEmpty) {
          Get.snackbar('Error', 'Please fill in repository details', backgroundColor: Colors.red, colorText: Colors.white);
          return;
        }
        data.addAll({
          'repository_name': storeNameController.text,
          'repository_address': storeAddressController.text,
          'repository_phone': storePhoneController.text,
        });
        endpoint = 'Repository/owner-register';
        break;

      case 'Pharmacist':
        endpoint = 'Pharmacy/Pharmacist-register';
        break;

      case 'RepositoryEmployee':
        endpoint = 'Repository/employee-register';
        break;

      default:
        Get.snackbar('Error', 'Please select a valid role', backgroundColor: Colors.red, colorText: Colors.white);
        return;
    }

    try {
      var response = await HttpHelper.postData(url: endpoint, body: data);
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      Map<String, dynamic> res = jsonDecode(response.body);
      print("Sending to [$endpoint]:");
      print(jsonEncode(data));
      if (response.statusCode == 200 || response.statusCode == 201) {
        token = res['data']['authorization']['token'];
        GetStorage().write('token', token);
        Get.snackbar('Success', res['status'].toString(), backgroundColor: AppColors.primaryColor, colorText: Colors.white);
        Get.offNamed('/test');
      } else {
      print("Sending to [$endpoint]:");
      print(jsonEncode(data));
        Get.snackbar('Error', res['message'].toString(), backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print('Register Error: $e');
      Get.snackbar('Exception', 'An error occurred during the registration process', backgroundColor: Colors.red, colorText: Colors.white);
    }
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
