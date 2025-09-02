import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configurations/http_helpers.dart';
import '../../helpers/connectivity_service_controller.dart';
import '../../helpers/request_queue_manager.dart';


class PermissionsController extends GetxController {
  RxBool isOffline = false.obs;
  RxList<Map<String, dynamic>> allPermissions = <Map<String, dynamic>>[].obs;
  RxList<String> selectedPermissionNames = <String>[].obs;
  RxList<Map<String, dynamic>> localNames = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> searchResults = <Map<String, dynamic>>[].obs;
  var nameSelectedFromResults = false.obs;
  bool ignoreNextInputChange = false;
  String lastText = '';
  int? selectedUserId;
  var nameController = TextEditingController();
  var roleController = TextEditingController();
  ConnectivityService connectivityService = Get.find<ConnectivityService>();
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
  @override
  void onReady() {
    super.onReady();
    Future.delayed(Duration.zero, () async {
      bool hasInternet = await connectivityService.isInternetAvailable();
      if (hasInternet) {
        connectivityService.showGreenBanner.value = true;

        Future.delayed(Duration(seconds: 3), () {
          connectivityService.showGreenBanner.value = false;
        });
      }
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
    bool hasRealInternet = await connectivityService.isInternetAvailable();
    if (hasRealInternet) {
      isOffline.value = false;
      print('[NETWORK] Internet is available, refreshing names from API...');
      await fetchNamesFromApi();
    } else {
      print('[NETWORK] No real internet connection, using cached names only.');
    }
  }
  Future<void> fetchNamesFromApi() async {
    try {
      final token = box.read<String>('token');
      print('[Eeeeeeeeeee] Token used: $token');
      var res = await HttpHelper.gettData(url: 'Repository/all-users');
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        List<Map<String, dynamic>> users = List<Map<String, dynamic>>.from(body['data']);
        localNames.value = users;
        box.write('cached_names', users);
        print('[API] Fetched ${users.length} users from API.');
      }
      else if(res.statusCode == 500) {
       Get.offNamed('/signIn');
      }
      else {
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
    await GetStorage.init();
    List? cachedPerms = box.read('cached_permissions');
    if (cachedPerms != null) {
      allPermissions.value = List<Map<String, dynamic>>.from(cachedPerms);
      print('[LOCAL] Loaded permissions from cache (${allPermissions.length})');
    }
    if (await connectivityService.isInternetAvailable()) {
      try {
        var res = await HttpHelper.gettData(url: 'Pharmacy/get-permissions/en');
        if (res.statusCode == 200) {
          var body = jsonDecode(res.body);
          List<Map<String, dynamic>> perms = List<Map<String, dynamic>>.from(body['data']);
          allPermissions.assignAll(perms);
          box.write('cached_permissions', perms);
          print('[API] Fetched and cached ${perms.length} permissions');
        } else {
          print('[API] Failed to fetch permissions. Status code: ${res.statusCode}');
        }
      } catch (e) {
        print('[API ERROR] $e');
        Get.snackbar('Error', 'Error updating permissions, using cached data', backgroundColor: Colors.red, colorText: Colors.white);
      }
    } else {
      if (cachedPerms == null) {
        print('No Internet No cached permissions available');
      } else {
        print('No Internet Using cached permissions');
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

    final requestBody = {
      'role': role,
      'permissions': jsonEncode(permissionIds),
    };

    final Map<String, dynamic> requestData = {
      'url': 'Pharmacy/assignOrUpdate-Permissions/$selectedUserId',
      'body': requestBody,
    };
    final connectivityService = Get.find<ConnectivityService>();
    final hasInternet = await connectivityService.isInternetAvailable();

    if (hasInternet) {
      try {
        final response = await HttpHelper.postData(
          url: requestData['url'] as String,
          body: Map<String, dynamic>.from(requestData['body'] as Map),
        );
        if (response.statusCode == 200) {

          Get.snackbar('Success', 'permissions assigned successfully to ${nameController.text.trim()}',
              backgroundColor: Colors.green.withOpacity(0.5), colorText: Colors.white,
            duration: const Duration(seconds: 3),);
          Get.offNamed('/home');
        } else {
          Get.snackbar('Failed', 'Failed to save data',
              backgroundColor: Colors.red, colorText: Colors.white);
          print('[SAVE] Status: ${response.statusCode}');
          print('[SAVE] Body: ${response.body}');
        }
      } catch (e) {
        print('Error while sending request: $e');
        // await RequestQueueManager.addToQueue(requestData);
        // Get.snackbar('Offline', 'Saved locally. Will send when online.',
        //     backgroundColor: Colors.orange, colorText: Colors.white);
      }
    } else {
      requestData['userName'] = nameController.text.trim();
      await RequestQueueManager.addToQueue(requestData);
      await RequestQueueManager.addToQueue(requestData);
      Get.snackbar('Offline', 'Saved locally. Will send when online.',
          backgroundColor: Colors.orange, colorText: Colors.white);
      Get.offNamed('/pharmacyManagementScreen');

    }
  }
  @override
  void onClose() {
    nameController.dispose();
    roleController.dispose();
    super.onClose();
  }
}
