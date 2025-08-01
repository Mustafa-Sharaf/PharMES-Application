import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pharmes_app/modules/my_pharmacy_management/queue_viewer.dart';
class ButtonController extends GetxController {
  var isPressed1 = false.obs;
  var isPressed2 = false.obs;

  void pressButton1() {
    isPressed1.value = true;
    Future.delayed(const Duration(milliseconds: 50), () {
      Get.toNamed('/permissionScreen');
      isPressed1.value = false;
    });
  }

  void pressButton2() {
    isPressed2.value = true;
    Future.delayed(const Duration(milliseconds: 50), () {
      Get.to(QueueViewer());
      isPressed2.value = false;
    });
  }
}
