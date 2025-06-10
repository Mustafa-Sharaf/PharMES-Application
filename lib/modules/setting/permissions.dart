import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      print('[NETWORK] Internet is available, refreshing names from API...');
      await fetchNamesFromApi();
    } else {
      print('[NETWORK] No internet connection, using cached names only.');
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
      }
    } catch (e) {
      print('[API ERROR] $e');
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
    try {
      var res = await HttpHelper.gettData(url: 'Pharmacy/get-permissions/en');
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        List<Map<String, dynamic>> perms = List<Map<String, dynamic>>.from(body['data']);
        allPermissions.assignAll(perms);
      }
    } catch (e) {
      Get.snackbar('Error', 'Error loading permissions: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
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
