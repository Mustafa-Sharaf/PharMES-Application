import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharmes_app/modules/my_pharmacy_management/pharmacy_management_controller.dart';
import '../../app_theme/app_colors.dart';
import '../../app_theme/theme_controller.dart';
import '../../widgets/build_pharmacy_management.dart';
import '../../widgets/camera_floating_button.dart';
class PharmacyManagementScreen extends StatelessWidget {
  PharmacyManagementScreen({super.key});

  final ButtonController buttonController = Get.put(ButtonController());
  final ThemeController themeController = Get.find();
  final GetStorage _box = GetStorage();

  @override
  Widget build(BuildContext context) {
    int role = _box.read('role_id') ?? 0;
    String titleText = 'My Pharmacy Management';
    if (role == 1) {
      titleText = 'My Pharmacy Repository';
    } else if (role == 3) {
      titleText = 'My Pharmacy Management';
    }
    return Scaffold(
      backgroundColor: themeController.isDarkMode.value ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(titleText,
            style:  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.055, color: Colors.white)),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            BuildPharmacyManagement(text:"My Stock" ,pathName:'/myStock' ,icon:Icons.medical_services ,),
            BuildPharmacyManagement(text:"My Pharmacists" ,pathName:'/myPharmacists' ,icon:Icons.group ,),
            BuildPharmacyManagement(text:"Determine Permissions" ,pathName:'/permissionScreen' ,icon:Icons.settings ,),
            BuildPharmacyManagement(text:"View Permissions" ,pathName:'/queueViewer' ,icon:Icons.remove_red_eye_rounded ,),
            BuildPharmacyManagement(text:"Inventory by Name " ,pathName:'/inventoryByName' ,icon:Icons.inventory ,),
            BuildPharmacyManagement(text:"Special Requests" ,pathName:'/specialRequests',icon: Icons.note_alt ,),
            BuildPharmacyManagement(text:"Returned medications" ,pathName:'/returnedMedications' ,icon:Icons.replay ,),


            BuildPharmacyManagement(text:"Customer Debts" ,pathName:'/customerDebts' ,icon:Icons.money_off ,),
            BuildPharmacyManagement(text:"Medicine Requests" ,pathName:'/medicineRequests' ,icon:Icons.receipt_long ,),
            BuildPharmacyManagement(text:"Foreign Medicine" ,pathName:'/foreignMedicineInventoryManagement',icon:Icons.medical_services_rounded,),









          /*  Padding(
              padding: const EdgeInsets.all(20),
              child: Obx(() {
                final isPressed = buttonController.isPressed1.value;

                return GestureDetector(
                  onTap: buttonController.pressButton1,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 50),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isPressed ? AppColors.primaryColor : AppColors.white,
                      borderRadius: BorderRadius.circular(isPressed ? 75 : 16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.settings,
                          color: isPressed ? Colors.white : AppColors.primaryColor,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Determine Permissions',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isPressed ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),*/
          /*  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() {
                final isPressed = buttonController.isPressed2.value;

                return GestureDetector(
                  onTap: buttonController.pressButton2,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 50),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isPressed ? AppColors.primaryColor : AppColors.white,
                      borderRadius: BorderRadius.circular(isPressed ? 75 : 16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 55),
                        Icon(
                          LucideIcons.eye,
                          color: isPressed ? Colors.white : AppColors.primaryColor,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'View Permissions',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isPressed ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),*/
          ],
        ),
      ),
      floatingActionButton: CameraFloatingButton()


    );
  }
}

