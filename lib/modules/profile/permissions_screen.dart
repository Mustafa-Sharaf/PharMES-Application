import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import 'package:pharmes_app/modules/profile/permissions_controller.dart';


class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    PermissionsController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text(' Setting',style: TextStyle(color: AppColors.white),),
        backgroundColor: AppColors.primaryColor,
      ),
      body:Stack(
          children: [
            Positioned(
              bottom: -50,
              right: -50,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -30,
              right: -30,
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -10,
              right: -10,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
      SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller.nameController,
              cursorColor: AppColors.primaryColor,
              onSubmitted: (value) {
                controller.onSearchSubmitted(value);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[150],
                hintText: 'Search for the name',
                suffixIcon: Icon(Icons.search, color: Colors.grey[700]),
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 10),
            Obx(() {
              final hasInput = controller.nameController.text.trim().isNotEmpty;
              final noResults = controller.searchResults.isEmpty;
              final selected = controller.nameSelectedFromResults.value;

              if (!hasInput || selected) return const SizedBox.shrink();

              if (noResults) {
                return const Text(
                  'No matching results',
                  style: TextStyle(color: Colors.red),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.searchResults.map((result) {
                  return ListTile(
                    title: Text(result['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    onTap: () {
                      controller.ignoreNextInputChange = true;
                      controller.nameController.text = result['name'];
                      controller.selectedUserId = result['id'];
                      controller.searchResults.clear();
                      controller.nameSelectedFromResults.value = true;
                      FocusScope.of(context).unfocus();
                    },
                  );
                }).toList(),

              );
            }),

            const SizedBox(height: 15),
            TextField(
              controller: controller.roleController,
              cursorColor: AppColors.primaryColor,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[150],
                hintText: 'Select the role',
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Permissions',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Obx(() => Column(
              children: controller.allPermissions.map((permission) {
                final name = permission['name_en'];
                return CheckboxListTile(
                  title: Text(name),
                  value: controller.selectedPermissionNames.contains(name),
                  onChanged: (_) => controller.togglePermission(name),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: AppColors.primaryColor,
                );
              }).toList(),
            )),
            Row(
              children: [
                SizedBox(width: screenWidth*0.65,),
                ElevatedButton( onPressed: () {
                  controller.saveRoleWithPermissions();
                }, child: Text('Save',style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor)),
              ],
            )
          ],
        ),
      ),]
    ));
  }
}
