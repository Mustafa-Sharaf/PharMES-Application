import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import '../../configurations/http_helpers.dart';

class SignInController extends GetxController {
  String? token;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> login(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showError('Please fill in all fields');
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      _showError('Please enter a valid email address');
      return;
    }

    if (password.length < 6) {
      _showError('Password must be at least 6 characters');
      return;
    }

    await HttpHelper.postData(
      url: 'Pharmacy/login',
      body: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    ).then((value) async {
      Map<String, dynamic> res = jsonDecode(value.body);
      print(res);

      if (value.statusCode == 200 || value.statusCode == 201) {
        token = res['data']['authorization']['token'];
        int role = res['data']['user']['role_id'];

        final _box = GetStorage();
        _box.write('token', token);
        _box.write('role_id', role);

        Get.snackbar(
          'Login Success',
          res['status'].toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
        );

        Get.offNamed('/home');
      } else if (value.statusCode == 406) {
        _showError(res['error'].toString(), title: 'Incorrect password or email');
      } else {
        _showError(res['message'].toString());
      }
    }).catchError((e) {
      print('login error: $e');
      _showError('An error occurred during the login process', title: 'Exception');
    });
  }




  void _showError(String message, {String title = 'Error'}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
