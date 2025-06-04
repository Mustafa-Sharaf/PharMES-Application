import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController{
  final emailPController = TextEditingController();

  @override
  void onClose() {
    emailPController.dispose();
    super.onClose();
  }
}