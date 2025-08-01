import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configurations/http_helpers.dart';
import '../../language/language_controller.dart';
import 'drugType_model.dart';

class DrugTypeController extends GetxController {
  var drugTypeMedicine = <DrugTypeMedicine>[].obs;
  var isLoading = false.obs;
  final MyLanguageController languageController = Get.find();

  Future<void> fetchDrugType(int id) async {
    isLoading.value = true;
    final box = GetStorage();
    final cacheKey = 'drugTypeMedicine_$id';
    final cacheTimeKey = 'drugTypeMedicine_last_fetch_$id';

    final cachedData = box.read(cacheKey);
    if (cachedData != null) {
      try {
        List jsonData = json.decode(cachedData);
        drugTypeMedicine.value =
            jsonData.map((e) => DrugTypeMedicine.fromJson(e)).toList();
      } catch (e) {
        print('خطأ في قراءة البيانات المخزنة: $e');
      }
    }

    final lastFetchTimeString = box.read(cacheTimeKey);
    DateTime? lastFetchTime = lastFetchTimeString != null
        ? DateTime.tryParse(lastFetchTimeString)
        : null;
    final now = DateTime.now();
    final shouldFetchFromApi =
        lastFetchTime == null || now.difference(lastFetchTime).inHours >= 24;

    if (shouldFetchFromApi) {
      try {
        final response =
        await HttpHelper.gettData(url: 'get/medbyForm_id/$id');

        if (response.statusCode == 200) {
          List jsonData = json.decode(response.body);
          drugTypeMedicine.value =
              jsonData.map((e) => DrugTypeMedicine.fromJson(e)).toList();
          box.write(cacheKey, response.body);
          box.write(cacheTimeKey, now.toIso8601String());
        } else {
          print('فشل في الجلب من السيرفر. الرمز: ${response.statusCode}');
        }
      } catch (e) {
        print('فشل الاتصال بالسيرفر، سيتم استخدام البيانات المخزنة فقط. الخطأ: $e');
      }
    }

    isLoading.value = false;
  }
}
