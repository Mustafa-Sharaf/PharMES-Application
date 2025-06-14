import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/modules/profile/profile_controller.dart';
import '../../configurations/http_helpers.dart';

class UpdateProfileController extends GetxController{
  final ProfileController controller = Get.find<ProfileController>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController info1Controller = TextEditingController();
  final TextEditingController info2Controller = TextEditingController();
  final TextEditingController info3Controller = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    nameController.text = controller.name.value;
    emailController.text = controller.email.value;
    phoneController.text = controller.phone.value;

    if (controller.otherInfo.length > 0) info1Controller.text = controller.otherInfo[0].values.first;
    if (controller.otherInfo.length > 1) info2Controller.text = controller.otherInfo[1].values.first;
    if (controller.otherInfo.length > 2) info3Controller.text = controller.otherInfo[2].values.first;
  }
  void updateProfile() {
    final role = controller.role.value;
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final pass = password.text.trim();
    final confirmPass = confirmPassword.text.trim();
    final info1 = info1Controller.text.trim();
    final info2 = info2Controller.text.trim();
    final info3 = info3Controller.text.trim();

    if (name.isEmpty || email.isEmpty || phone.isEmpty || pass.isEmpty || confirmPass.isEmpty) {
      Get.snackbar('Error', 'All fields are required');
      return;
    }

    Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'phone_number': phone,
      'password': pass,
      'confirm_password': confirmPass,
    };

    String endpoint = '';

    if (role == 1) {
      if (info1.isEmpty || info2.isEmpty || info3.isEmpty) {
        Get.snackbar('Error', 'Repository name, address, and phone are required');
        return;
      }
      data.addAll({
        'repository_name': info1,
        'repository_phone': info2,
        'repository_address': info3,
      });
      endpoint = 'Repository/update-profile';

    } else if (role == 3) {
      endpoint = 'Repository/update-profile';

    } else if (role == 2 || role == 4) {
      if (role == 2 && (info1.isEmpty || info2.isEmpty || info3.isEmpty)) {
        Get.snackbar('Error', 'Pharmacy name, address, and phone are required');
        return;
      }
      if (role == 2) {
        data.addAll({
          'pharmacy_name': info1,
          'pharmacy_address': info2,
          'pharmacy_phone': info3,
        });
      }
      endpoint = 'Pharmacy/update-profile';
    } else {
      Get.snackbar('Error', 'Unknown user role');
      return;
    }
    HttpHelper.postData(url: endpoint, body: data).then((response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Profile updated successfully');
        controller.fetchProfileData();
        Get.offNamed('/profileScreen');


      } else {
        print('Failed: ${response.statusCode}');
        print('Response: ${response.body}');
        Get.snackbar('Error', 'Update failed: ${jsonDecode(response.body)['message'] ?? 'Unknown error'}');
      }
    }).catchError((error) {
      print('Error: $error');
      Get.snackbar('Error', 'An error occurred: $error');
    });
  }

}