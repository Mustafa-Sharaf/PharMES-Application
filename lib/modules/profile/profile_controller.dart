import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configurations/http_helpers.dart';
import 'dart:convert';

class ProfileController extends GetxController {
  final GetStorage _box = GetStorage();
  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxString phone = ''.obs;
  final RxList<Map<String, String>> otherInfo = <Map<String, String>>[].obs;
  final RxInt role = 0.obs;

  @override
  void onInit() {
    super.onInit();
    print('[INIT] Controller initialized');
    _loadFromCache();
    fetchProfileData();
  }

  void _loadFromCache() {
    print('[CACHE] Loading data from GetStorage...');
    name.value = _box.read('name') ?? '';
    email.value = _box.read('email') ?? '';
    phone.value = _box.read('phone') ?? '';
    print('[CACHE] Name: ${name.value}');
    print('[CACHE] Email: ${email.value}');
    print('[CACHE] Phone: ${phone.value}');

    final cachedOtherInfo = _box.read('otherInfo');
    if (cachedOtherInfo != null) {
      print('[CACHE] Found otherInfo: $cachedOtherInfo');
      otherInfo.value = List<Map<String, String>>.from(
        (cachedOtherInfo as List).map(
              (item) => Map<String, String>.from(item as Map),
        ),
      );
    } else {
      print('[CACHE] No otherInfo found.');
      otherInfo.clear();
    }

    role.value = _box.read('role_id') ?? 0;
    print('[CACHE] Role: ${role.value}');
  }

  void _saveToCache() {
    print('[CACHE] Saving data to GetStorage...');
    print('[CACHE] Name: ${name.value}');
    print('[CACHE] Email: ${email.value}');
    print('[CACHE] Phone: ${phone.value}');
    print('[CACHE] Role: ${role.value}');
    print('[CACHE] otherInfo: $otherInfo');

    _box.write('name', name.value);
    _box.write('email', email.value);
    _box.write('phone', phone.value);
    _box.write('otherInfo', otherInfo.toList());
    _box.write('role_id', role.value);
  }

  void fetchProfileData() async {
    try {
      print('[FETCH] Fetching profile data...');
      int storedRole = GetStorage().read('role_id') ?? 0;
      role.value = storedRole;
      print('[FETCH] Stored role: $storedRole');

      if (storedRole == 1 || storedRole == 3) {
        print('[FETCH] Loading repository data...');
        await _loadRepoData();
      } else if (storedRole == 2 || storedRole == 4) {
        print('[FETCH] Loading pharmacy data...');
        await _loadPharmaData();
      }

      _saveToCache();
    } catch (e) {
      print('[EXCEPTION in fetchProfileData] $e');
    }
  }

  Future<void> _loadRepoData() async {
    print('[API] Calling Repository/my-profile...');
    var response = await HttpHelper.gettData(url: 'Repository/my-profile');
    print('[API] Response status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      print('[API] Repository data loaded: $data');

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
      print('[API] otherInfo updated: $otherInfo');
    } else {
      print('[API] Failed to load repository data');
    }
  }

  Future<void> _loadPharmaData() async {
    print('[API] Calling Pharmacy/my-profile...');
    var response = await HttpHelper.gettData(url: 'Pharmacy/my-profile');
    print('[API] Response status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      print('[API] Pharmacy data loaded: $data');

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
      print('[API] otherInfo updated: $otherInfo');
    } else {
      print('[API] Failed to load pharmacy data');
    }
  }
}
