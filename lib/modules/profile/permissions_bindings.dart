import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:pharmes_app/modules/profile/permissions_controller.dart';

import 'package:pharmes_app/modules/sign_in/sign_in_controller.dart';

class PermissionsBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<PermissionsController>(PermissionsController(),permanent: true);
  }

}