import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:pharmes_app/modules/permissions/permissions_controller.dart';
import '../../helpers/connectivity_service_controller.dart';



class PermissionsBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<ConnectivityService>(ConnectivityService(),permanent: true);
    Get.put<PermissionsController>(PermissionsController());

  }

}