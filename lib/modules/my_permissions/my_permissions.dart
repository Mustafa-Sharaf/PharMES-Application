import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import 'my_permissions_controller.dart';
import 'my_permissions_model.dart';

class MyPermissionsScreen extends StatelessWidget {
  const MyPermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyPermissionsController controller = Get.put(MyPermissionsController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.white,
          title: Text(
              "My_Permissions".tr,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: controller.allPermissions.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final Permission perm = controller.allPermissions[index];
            return ListTile(
              leading: const Icon(Icons.key, color: AppColors.primaryColor),
              title: Text(perm.nameEn, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(perm.nameAr, style: const TextStyle(color: Colors.grey)),
            );
          },
        ),
      );
    });
  }
}
