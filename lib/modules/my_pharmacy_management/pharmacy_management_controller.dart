import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ButtonController extends GetxController {
  var isPressed = false.obs;

  void pressButton() {
    isPressed.value = true;

    Future.delayed(const Duration(milliseconds: 200), () {
      Get.toNamed('/permissionScreen');
      isPressed.value = false;
    });
  }
}