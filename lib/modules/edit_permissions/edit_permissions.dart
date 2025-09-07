import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import '../../app_theme/theme_controller.dart';
import 'edit_permissions_controller.dart';

class EditPermissionsScreen extends StatelessWidget {
  final int userId;
  final String userName;

  const EditPermissionsScreen({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final EditPermissionsController controller = Get.put(EditPermissionsController(),);
    controller.loadUserPermissions(userId, userName);
    final ThemeController themeController = Get.find();

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.white,
          title: Text(
            "Edit_Permissions".tr,
            style: TextStyle(
              color: AppColors.white,
              fontSize: MediaQuery.of(context).size.width * 0.05,
            ),
          ),
        ),
        body: controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller.roleController,
                      decoration: InputDecoration(
                        labelText: 'Role'.tr,
                        filled: true,
                        fillColor: themeController.isDarkMode.value
                            ? AppColors.componentDark
                            : Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Permissions_for".tr,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: userName,
                            style: const TextStyle(
                              //fontStyle: FontStyle.italic,
                              fontSize: 14,
                              color: AppColors.DarkGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => Column(
                        children: controller.allPermissions.map((permission) {
                          final id = permission['id'] as int;
                          final name = permission['name_en'] as String;
                          return CheckboxListTile(
                            title: Text(name),
                            value: controller.selectedPermissionIds.contains(
                              id,
                            ),
                            onChanged: (_) => controller.togglePermission(id),
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: AppColors.primaryColor,
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.saveUpdatedPermissions();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                        ),
                        child: Text(
                          'Save'.tr,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
