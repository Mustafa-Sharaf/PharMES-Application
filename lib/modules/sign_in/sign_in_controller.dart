import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import '../../configurations/http_helpers.dart';
import '../test.dart';


class SignInController extends GetxController {
  String? token;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  login(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text;
    if (email.isEmpty || password.isEmpty ) {
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
    await HttpHelper.postData(
      url: 'Pharmacy/login',
      body: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    ).then((value) {
      Map<String, dynamic> res = jsonDecode(value.body);
      print(res);
      if (value.statusCode == 200 || value.statusCode == 201) {
        token = res['data']['authorization']['token'];
        GetStorage _box = GetStorage();
        _box.write('token', token);
        //HttpHelper.token = token;
        Get.snackbar(' ', res['status'].toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.primaryColor,
            colorText: Colors.white);
            Get.to(Test());
       //Get.offNamed('/setting');
      }
      else if(value.statusCode == 406) {
        Get.snackbar(' Incorrect password or email', res['error'].toString(),
            backgroundColor: Colors.red, colorText: Colors.white);
      }
      else {
        Get.snackbar(' ', res['message'].toString(),
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }).catchError((e) {
      print('login error: $e');
      Get.snackbar('Exception', 'An error occurred during the log in process',
          backgroundColor: Colors.red, colorText: Colors.white);
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
