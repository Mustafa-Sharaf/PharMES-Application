/*
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configurations/http_helpers.dart';
import 'my_permissions_model.dart';

class MyPermissionsController extends GetxController {
  var isLoading = true.obs;
  var allPermissions = <Permission>[].obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadPermissions();
  }

  Future<void> loadPermissions() async {
    isLoading.value = true;

    // محاولة تحميل من الكاش أولاً
    final cached = box.read('cached_permissions');
    if (cached != null) {
      allPermissions.value = List<Map<String, dynamic>>.from(cached)
          .map((e) => Permission.fromJson(e))
          .toList();
    }

    try {
      final res = await HttpHelper.gettData(url: 'Pharmacy/get-MyPermissions');
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        List<Permission> perms = List<Map<String, dynamic>>.from(body['data'])
            .map((e) => Permission.fromJson(e))
            .toList();
        allPermissions.assignAll(perms);
        box.write('cached_permissions', perms.map((e) => {
          'id': e.id,
          'name_en': e.nameEn,
          'name_ar': e.nameAr,
        }).toList());
      }
    } catch (e) {
      print('Error fetching permissions: $e');
    }

    isLoading.value = false;



  }
}
*/

import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configurations/http_helpers.dart';
import 'my_permissions_model.dart';

class MyPermissionsController extends GetxController {
  var isLoading = true.obs;
  var allPermissions = <Permission>[].obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadPermissions();
  }

  Future<void> loadPermissions() async {
    isLoading.value = true;


    final cached = box.read('cached_permissions');
    if (cached != null) {
      allPermissions.value = List<Map<String, dynamic>>.from(cached)
          .map((e) => Permission.fromJson(e))
          .toList();
    }

    try {
      final res = await HttpHelper.gettData(url: 'Pharmacy/get-MyPermissions');
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        List<Permission> perms = List<Map<String, dynamic>>.from(body['data'])
            .map((e) => Permission.fromJson(e))
            .toList();
        allPermissions.assignAll(perms);
        box.write(
          'cached_permissions',
          perms
              .map((e) => {
            'id': e.id,
            'name_en': e.nameEn,
            'name_ar': e.nameAr,
          })
              .toList(),
        );
      }
    } catch (e) {
      print('Error fetching permissions: $e');
    }

    isLoading.value = false;
  }
}


extension PermissionChecker on MyPermissionsController {
  bool hasPermission(int id) {
    return allPermissions.any((p) => p.id == id);
  }
}


