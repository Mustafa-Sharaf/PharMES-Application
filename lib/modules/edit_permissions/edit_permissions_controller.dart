import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configurations/http_helpers.dart';
import 'edit_permissions_model.dart';

class EditPermissionsController extends GetxController {
  var isLoading = false.obs;
  var allPermissions = <Map<String, dynamic>>[].obs;
  var selectedPermissionIds = <int>[].obs;

  var roleController = TextEditingController();
  var userName = ''.obs;
  var userId = 0;
  final box = GetStorage();

  Future<void> loadUserPermissions(int targetUserId, String targetName) async {
    if (userId == targetUserId && roleController.text.isNotEmpty) return;

    userId = targetUserId;
    userName.value = targetName;

    isLoading.value = true;

    try {
      final res = await HttpHelper.gettData(
          url: 'Pharmacy/get-permissions/Pharmacist/$targetUserId');

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        final data = body['data'][0];
        final parsed = MyPharmacistsPermission.fromJson(data);
        roleController.text = parsed.role;
        selectedPermissionIds.value =
            parsed.permissions.map((e) => e.id).toList();

        final cachedPerms = box.read('cached_permissions');
        if (cachedPerms != null) {
          allPermissions.value = List<Map<String, dynamic>>.from(cachedPerms);
        } else {
          final permsRes =
          await HttpHelper.gettData(url: 'Pharmacy/get-permissions/en');
          if (permsRes.statusCode == 200) {
            var body = jsonDecode(permsRes.body);
            List<Map<String, dynamic>> perms =
            List<Map<String, dynamic>>.from(body['data']);
            allPermissions.assignAll(perms);
            box.write('cached_permissions', perms);
          }
        }
      }
    } catch (e) {
      print('Error loading user permissions: $e');
    }

    isLoading.value = false;
  }

  void togglePermission(int id) {
    if (selectedPermissionIds.contains(id)) {
      selectedPermissionIds.remove(id);
    } else {
      selectedPermissionIds.add(id);
    }
  }

  Future<void> saveUpdatedPermissions() async {
    final role = roleController.text.trim();
    if (role.isEmpty || selectedPermissionIds.isEmpty) {
      Get.snackbar('Error', 'Role and permissions must be provided',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    final body = {
      'role': role,
      'permissions': jsonEncode(selectedPermissionIds),
    };

    try {
      final response = await HttpHelper.postData(
        url: 'Pharmacy/assignOrUpdate-Permissions/$userId',
        body: body,
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Permissions updated for ${userName.value}',
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.offNamed('/pharmacyManagementScreen');
      } else {
        Get.snackbar('Error', 'Failed to update permissions',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Exception: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  void onClose() {
    roleController.dispose();
    super.onClose();
  }
}

