import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';

import '../../configurations/http_helpers.dart';

class PermissionsController extends GetxController {
  var nameController = TextEditingController();
  var roleController = TextEditingController();


  RxList<Map<String, dynamic>> allPermissions = <Map<String, dynamic>>[].obs;
  RxList<String> selectedPermissionNames = <String>[].obs;

  RxList<Map<String, dynamic>> localNames = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> searchResults = <Map<String, dynamic>>[].obs;
  int? selectedUserId;

  var nameSelectedFromResults = false.obs;
  bool ignoreNextInputChange = false;
  String lastText = '';


  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    initializeNameList();
    fetchPermissions();

    nameController.addListener(() {
      final currentText = nameController.text.trim();

      if (ignoreNextInputChange) {
        ignoreNextInputChange = false;
        return;
      }
      lastText = currentText;
      nameSelectedFromResults.value = false;
    });
  }

  Future<bool> isInternetAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(Duration(seconds: 3));
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
  void initializeNameList() async {
    await GetStorage.init();

    List? cached = box.read('cached_names');
    if (cached != null) {
      localNames.value = List<Map<String, dynamic>>.from(cached);
      print('[LOCAL] Loaded users from cache (${localNames.length})');
    } else {
      print('[REMOTE] No cache found, fetching from API...');
      await fetchNamesFromApi();
    }

    bool hasRealInternet = await isInternetAvailable();
    if (hasRealInternet) {
      Get.snackbar('', 'Updating data',
          backgroundColor: AppColors.primaryColor, colorText: Colors.white);
      print('[NETWORK] Internet is available, refreshing names from API...');
      await fetchNamesFromApi();
    } else {
      Get.snackbar('', 'No internet connection',
          backgroundColor: AppColors.primaryColor, colorText: Colors.white);
      print('[NETWORK] No real internet connection, using cached names only.');
    }
  }

  Future<void> fetchNamesFromApi() async {
    try {
      var res = await HttpHelper.gettData(url: 'Repository/all-users');
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        List<Map<String, dynamic>> users = List<Map<String, dynamic>>.from(body['data']);
        localNames.value = users;
        box.write('cached_names', users);
        print('[API] Fetched ${users.length} users from API.');
      } else {
        print('[API] Failed to fetch names. Status code: ${res.statusCode}');
        Get.snackbar('Warning', 'Failed to refresh users, using cached data', backgroundColor: Colors.orange, colorText: Colors.white);
      }
    } catch (e) {
      print('[API ERROR] $e');
      Get.snackbar('Error', 'Error updating users, using cached data', backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
  void onSearchSubmitted(String input) {
    final query = input.trim().toLowerCase();
    final exactMatches = localNames
        .where((user) => user['name'].toString().toLowerCase()==query)
        .toList();

    searchResults.value = exactMatches;
    nameSelectedFromResults.value = false;

    if (exactMatches.isEmpty) {
      print('[SEARCH] No exact match for "$query"');
    } else {
      print('[SEARCH] Found ${exactMatches.length} matches');
    }
  }


  void togglePermission(String permissionName) {
    if (selectedPermissionNames.contains(permissionName)) {
      selectedPermissionNames.remove(permissionName);
    } else {
      selectedPermissionNames.add(permissionName);
    }
  }

  void fetchPermissions() async {
    await GetStorage.init();
    List? cachedPerms = box.read('cached_permissions');
    if (cachedPerms != null) {
      allPermissions.value = List<Map<String, dynamic>>.from(cachedPerms);
      print('[LOCAL] Loaded permissions from cache (${allPermissions.length})');
    }

    if (await isInternetAvailable()) {
      try {
        var res = await HttpHelper.gettData(url: 'Pharmacy/get-permissions/en');
        if (res.statusCode == 200) {
          var body = jsonDecode(res.body);
          List<Map<String, dynamic>> perms = List<Map<String, dynamic>>.from(body['data']);
          allPermissions.assignAll(perms);
          box.write('cached_permissions', perms);
          Get.snackbar('Updated', 'Permissions updated', backgroundColor: Colors.green, colorText: Colors.white);
          print('[API] Fetched and cached ${perms.length} permissions');
        } else {
          print('[API] Failed to fetch permissions. Status code: ${res.statusCode}');
          Get.snackbar('Warning', 'Failed to refresh permissions, using cached data', backgroundColor: Colors.orange, colorText: Colors.white);
        }
      } catch (e) {
        print('[API ERROR] $e');
        Get.snackbar('Error', 'Error updating permissions, using cached data', backgroundColor: Colors.red, colorText: Colors.white);
      }
    } else {
      if (cachedPerms == null) {
        Get.snackbar('No Internet', 'No cached permissions available', backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        Get.snackbar('No Internet', 'Using cached permissions', backgroundColor: Colors.orange, colorText: Colors.white);
      }
      print('[NETWORK] No internet connection, using cached permissions only.');
    }
  }


  List<int> getSelectedPermissionIds() {
    return allPermissions
        .where((permission) => selectedPermissionNames.contains(permission['name_en']))
        .map<int>((permission) => permission['id'] as int)
        .toList();
  }


  Future<void> saveRoleWithPermissions() async {
    if (selectedUserId == null) {
      Get.snackbar('Error', 'Please select a user',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    final role = roleController.text.trim();
    final permissionIds = getSelectedPermissionIds();

    if (role.isEmpty || permissionIds.isEmpty) {
      Get.snackbar('Error', 'Role and permissions must be provided',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {

      final response = await HttpHelper.postData(
        url:'Pharmacy/assign-permissions/${selectedUserId!}',
        body: {
          'role': role,
          'permissions':  jsonEncode(permissionIds),
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Role and permissions saved successfully',
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar('Failed', 'Failed to save data',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {print('Error An error occurred: $e');
      Get.snackbar('Error', 'An error occurred: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }


  @override
  void onClose() {
    nameController.dispose();
    roleController.dispose();
    super.onClose();
  }
}
