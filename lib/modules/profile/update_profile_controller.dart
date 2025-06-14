import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/modules/profile/profile_controller.dart';

class UpdateProfileController extends GetxController{
  final ProfileController controller = Get.find<ProfileController>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController info1Controller = TextEditingController();
  final TextEditingController info2Controller = TextEditingController();
  final TextEditingController info3Controller = TextEditingController();

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
}