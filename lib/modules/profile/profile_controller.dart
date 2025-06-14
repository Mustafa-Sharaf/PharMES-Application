import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configurations/http_helpers.dart';
import 'dart:convert';
class ProfileController extends GetxController {
  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxString phone = ''.obs;
  final RxList<Map<String, String>> otherInfo = <Map<String, String>>[].obs;
  final RxInt role = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  void fetchProfileData() async {
    try {
      int storedRole = GetStorage().read('role_id') ?? 0;
      role.value = storedRole;
      print('$role');

      if (storedRole == 1 || storedRole == 3) {
        await _loadRepoData();
      } else if (storedRole == 2 || storedRole == 4) {
        await _loadPharmaData();
      }
    } catch (e) {
      print('[EXCEPTION] $e');
    }
  }

  Future<void> _loadRepoData() async {print('e');
    var response = await HttpHelper.gettData(url: 'Repository/my-profile');
  print(response.statusCode);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      name.value = data['name'] ?? '';
      email.value = data['email'] ?? '';
      phone.value = data['phone_number'] ?? '';
      otherInfo.clear();
      if (role.value == 1) {
        otherInfo.addAll([
          {'Repository Name': data['repository_name'] ?? ''},
          {'Repository Phone': data['repository_phone'] ?? ''},
          {'Repository Address': data['repository_address'] ?? ''},
        ]);
      }
    }
  }

  Future<void> _loadPharmaData() async {
    var response = await HttpHelper.gettData(url: 'Pharmacy/my-profile');
    print('pharmacy');
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('pharmacy2');
      final data = jsonDecode(response.body)['data'];
      name.value = data['name'] ?? '';
      email.value = data['email'] ?? '';
      phone.value = data['phone_number'] ?? '';
      otherInfo.clear();
      if (role.value == 2) {
        otherInfo.addAll([
          {'Pharmacy Name': data['pharmacy_name'] ?? ''},
          {'Pharmacy Phone': data['pharmacy_phone'] ?? ''},
          {'Pharmacy Address': data['pharmacy_address'] ?? ''},
        ]);
      }
    }
  }
}
