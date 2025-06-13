import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:pharmes_app/modules/profile/permissions_controller.dart';
import 'connectivity_service_controller.dart';

class PermissionsBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<ConnectivityService>(ConnectivityService(),permanent: true);
    Get.put<PermissionsController>(PermissionsController(),permanent: true);

  }

}