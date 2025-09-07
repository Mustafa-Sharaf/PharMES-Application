import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../app_theme/app_colors.dart';
import '../edit_permissions/edit_permissions.dart';
import '../my_permissions/my_permissions_controller.dart';
import 'my_Pharmacists_controller.dart';

class MyPharmacistsPage extends StatelessWidget {
  const MyPharmacistsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MyPharmacistsController controller = Get.put(MyPharmacistsController(),);
    final GetStorage box = GetStorage();
    int role = box.read('role_id') ?? 0;
    final MyPermissionsController permController = Get.find();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        title: Text(
          "My_Pharmacists".tr,
          style: TextStyle(
            color: AppColors.white,
            fontSize: MediaQuery.of(context).size.width * 0.05,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.pharmacists.isEmpty) {
          return  Center(child: Text( "My_Pharmacists".tr));
        }
        return ListView.builder(
          itemCount: controller.pharmacists.length,
          itemBuilder: (context, index) {
            final pharmacist = controller.pharmacists[index];
            final user = pharmacist.user;
            return Padding(
              padding: const EdgeInsets.only(left: 4, right: 4, top: 4),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: ListTile(
                    leading: const Text(
                      "👨‍⚕️",
                      style: TextStyle(fontSize: 30),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              user.email,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "📞 ${user.phoneNumber}",
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Role: ${pharmacist.role}",
                              style: const TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (role == 1 || role == 2 || permController.hasPermission(13))
                            IconButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  title: 'Confirm Delete',
                                  middleText:
                                  'Are you sure you want to remove ${pharmacist.user.name}?',
                                  textCancel: 'Cancel',
                                  textConfirm: 'Delete',
                                  confirmTextColor: Colors.white,
                                  cancelTextColor: AppColors.primaryColor,
                                  buttonColor: AppColors.primaryColor,
                                  onConfirm: () {
                                    controller.deletePharmacist(pharmacist.id);
                                    Get.back();
                                  },
                                );
                              },
                              icon: Icon(Icons.delete, size: 30, color: Colors.red),
                            ),

                            IconButton(
                              onPressed: () {
                                Get.to(
                                      () => EditPermissionsScreen(
                                    userId: user.id,
                                    userName: user.name,
                                  ),
                                );
                              },
                              icon: Icon(Icons.edit, color: Colors.orange),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
