import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configurations/http_helpers.dart';
import 'my_Pharmacists_model.dart';

class MyPharmacistsController extends GetxController {
  var pharmacists = <Pharmacist>[].obs;
  var isLoading = false.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchPharmacists();
  }

  Future<void> fetchPharmacists() async {
    isLoading.value = true;

    try {
      final response = await HttpHelper.gettData(url: 'Pharmacy/My-Pharmacists');
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        var parsed = MyPharmacists.fromJson(jsonData);
        pharmacists.value = parsed.data;

        box.write('my_pharmacists', json.encode(jsonData));
      } else {
        print('فشل في الجلب من السيرفر. الرمز: ${response.statusCode}');
        _loadFromCache();
      }
    } catch (e) {
      print('فشل الاتصال بالسيرفر: $e');
      _loadFromCache();
    }

    isLoading.value = false;
  }

  void _loadFromCache() {
    final cachedData = box.read('my_pharmacists');
    if (cachedData != null) {
      try {
        Map<String, dynamic> jsonData = json.decode(cachedData);
        pharmacists.value = MyPharmacists.fromJson(jsonData).data;
      } catch (e) {
        print('خطأ في قراءة البيانات من الكاش: $e');
      }
    }
  }

  Future<void> deletePharmacist(int id) async {
    try {
      final response = await HttpHelper.postData(
        url: 'Pharmacy/delete-MyPharmacist/$id',
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == 'Success') {
          pharmacists.removeWhere((p) => p.id == id);

          await fetchPharmacists();

          Get.snackbar(
            'Success',
            jsonData['data'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Error',
            'فشل في الحذف',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'فشل في الاتصال بالسيرفر. الرمز: ${response.statusCode}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'حدث خطأ أثناء الحذف: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> refreshAfterAdd() async {
    await fetchPharmacists();
  }
}
