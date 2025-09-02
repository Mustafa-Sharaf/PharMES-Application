import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configurations/http_helpers.dart';
import 'medicine_content_model.dart';

class HomeContentController extends GetxController {
  var medicines = <Medicine>[].obs;
  var filteredMedicines = <Medicine>[].obs;
  var isLoading = false.obs;
  var recentSearches = <String>[].obs;

  @override
  void onInit() {
    fetchMedicines();
    super.onInit();
  }

  Future<void> fetchMedicines() async {
    isLoading.value = true;

    final box = GetStorage();
    final cachedData = box.read('medicines');

    if (cachedData != null) {
      try {
        List jsonData = json.decode(cachedData);
        medicines.value =
            jsonData.map((item) => Medicine.fromJson(item)).toList();
        filteredMedicines.assignAll(medicines);
      } catch (e) {
        print('خطأ في قراءة البيانات المخزنة: $e');
      }
    }

    final lastFetchTimeString = box.read('medicines_last_fetch');
    DateTime? lastFetchTime = lastFetchTimeString != null
        ? DateTime.tryParse(lastFetchTimeString)
        : null;
    final now = DateTime.now();

    final shouldFetchFromApi =
        lastFetchTime == null || now.difference(lastFetchTime).inHours >= 8;

    if (shouldFetchFromApi) {
      try {
        final response = await HttpHelper.gettData(url: 'get');

        if (response.statusCode == 200) {
          List jsonData = json.decode(response.body);
          medicines.value =
              jsonData.map((item) => Medicine.fromJson(item)).toList();
          filteredMedicines.assignAll(medicines);
          box.write('medicines', response.body);
          box.write('medicines_last_fetch', now.toIso8601String());
        } else {
          Get.snackbar(
            'Error'.tr,
            'Failed_to_fetch_medications'.tr,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Exception'.tr,
          'تعذر الاتصال بالسيرفر، عرض البيانات المخزنة.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print('Exception: $e');
      }
    }

    isLoading.value = false;
  }



  void searchMedicines(String query) {
    if (query.isEmpty) {
      filteredMedicines.assignAll(medicines);
      return;
    }
    filteredMedicines.assignAll(
      medicines.where((med) =>
      med.tradeName.toLowerCase().contains(query.toLowerCase()) ||
          med.composition.toLowerCase().contains(query.toLowerCase()) ||
          med.laboratory.toLowerCase().contains(query.toLowerCase())),
    );
  }
  void addRecentSearch(String searchTerm) {
    if (searchTerm.isNotEmpty && !recentSearches.contains(searchTerm)) {
      recentSearches.insert(0, searchTerm);
      if (recentSearches.length > 10) {
        recentSearches.removeLast();
      }
    }
  }

  void clearRecentSearches() {
    recentSearches.clear();
  }

}
