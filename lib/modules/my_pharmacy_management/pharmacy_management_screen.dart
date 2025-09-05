import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../app_theme/app_colors.dart';
import '../../app_theme/theme_controller.dart';
import '../my_permissions/my_permissions_controller.dart';
import '../../widgets/build_pharmacy_management.dart';
import '../../widgets/camera_floating_button.dart';


class PharmacyManagementScreen extends StatelessWidget {
  PharmacyManagementScreen({super.key});

  final ThemeController themeController = Get.find();
  final GetStorage _box = GetStorage();
  final MyPermissionsController permController = Get.put(MyPermissionsController());

  @override
  Widget build(BuildContext context) {
    int role = _box.read('role_id') ?? 0;
    String titleText = 'My_Pharmacy_Management'.tr;

    if (role == 1) {
      titleText = 'My Repository'.tr;
    } else if (role == 3) {
      titleText = 'My_Pharmacy_Management'.tr;
    }
    return Obx(() {
      if ((role == 3 || role == 4) && permController.isLoading.value) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      return Scaffold(
        backgroundColor: themeController.isDarkMode.value
            ? AppColors.backgroundDark
            : AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: Text(
            titleText,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.055,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              if (role == 1 || role == 2 || permController.hasPermission(1))
                BuildPharmacyManagement(
                  text: "My_Stock".tr,
                  pathName: '/myStock',
                  icon: Icons.medical_services,
                ),

              if (role == 1 || role == 2 || permController.hasPermission(2))
                BuildPharmacyManagement(
                  text: "My_Pharmacists".tr,
                  pathName: '/myPharmacists',
                  icon: Icons.group,
                ),

              if (role == 1 || role == 2 || permController.hasPermission(3))
                BuildPharmacyManagement(
                  text: "Determine_Permissions".tr,
                  pathName: '/permissionScreen',
                  icon: Icons.settings,
                ),

              if (role == 1 || role == 2 || permController.hasPermission(4))
                BuildPharmacyManagement(
                  text: "View_Permissions".tr,
                  pathName: '/queueViewer',
                  icon: Icons.remove_red_eye_rounded,
                ),

              if (role == 1 || role == 2 || permController.hasPermission(5))
                BuildPharmacyManagement(
                  text: "Inventory_by_Name".tr,
                  pathName: '/inventoryByName',
                  icon: Icons.inventory,
                ),

              if (role == 1 || role == 2 || permController.hasPermission(15))
                BuildPharmacyManagement(
                  text: "Special_Requests".tr,
                  pathName: '/specialRequests',
                  icon: Icons.note_alt,
                ),

              if (role == 1 || role == 2 || permController.hasPermission(16))
                BuildPharmacyManagement(
                  text: "Returned_medications".tr,
                  pathName: '/returnedMedications',
                  icon: Icons.replay,
                ),

              if (role == 1 || role == 2 || permController.hasPermission(17))
                BuildPharmacyManagement(
                  text: "My_Permissions".tr,
                  pathName: '/myPermissionsScreen',
                  icon: Icons.key,
                ),

              if (role == 1 || role == 2 || permController.hasPermission(13))
                BuildPharmacyManagement(
                  text: "Customer_Debts".tr,
                  pathName: '/customerDebts',
                  icon: Icons.money_off,
                ),

              if (role == 1 || role == 2 || permController.hasPermission(11))
                BuildPharmacyManagement(
                  text: "Medicine_Requests".tr,
                  pathName: '/medicineRequests',
                  icon: Icons.receipt_long,
                ),

              if (role == 1 || role == 2 || permController.hasPermission(5))
                BuildPharmacyManagement(
                  text: "Foreign_Medicine".tr,
                  pathName: '/foreignMedicineInventoryManagement',
                  icon: Icons.medical_services_rounded,
                ),
              if (role == 1 || role == 2 || permController.hasPermission(5))
                BuildPharmacyManagement(
                  text: "My_Orders".tr,
                  pathName: '/myOrdersScreen',
                  icon: Icons.receipt_long,
                ),
                SizedBox(height: 40,)
            ],
          ),
        ),


        floatingActionButton:
        (role == 1 || role == 2 || permController.hasPermission(1))
            ? CameraFloatingButton()
            : null,
      );
    });
  }
}






