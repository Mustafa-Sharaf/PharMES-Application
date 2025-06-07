import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:pharmes_app/modules/sign_in/sign_in_controller.dart';

class SignInBindings implements Bindings{
  @override
  void dependencies() {
     Get.put<SignInController>(SignInController());
  }

}