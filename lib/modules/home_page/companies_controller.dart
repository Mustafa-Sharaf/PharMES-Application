import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configurations/http_helpers.dart';
import '../../language/language_controller.dart';
import 'companies_model.dart';

class CompaniesController extends GetxController {
  var companies = <Company>[].obs;
  var isLoading = false.obs;

  final MyLanguageController languageController = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchCompanies();
  }

  Future<void> fetchCompanies() async {
    final box = GetStorage();
    final cachedData = box.read('companies');
    if (cachedData != null) {
      try {
        List jsonData = json.decode(cachedData);
        companies.value = jsonData.map((e) => Company.fromJson(e)).toList();
      } catch (e) {
        print('خطأ في قراءة البيانات المخزنة: $e');
      }
    }

    final lastFetchTimeString = box.read('companies_last_fetch');
    DateTime? lastFetchTime = lastFetchTimeString != null
        ? DateTime.tryParse(lastFetchTimeString)
        : null;
    final now = DateTime.now();
    final shouldFetchFromApi =
        lastFetchTime == null || now.difference(lastFetchTime).inHours >= 24;

    if (shouldFetchFromApi) {
      try {
        final response = await HttpHelper.gettData(url: 'getcompanies');
        if (response.statusCode == 200) {
          List jsonData = json.decode(response.body);
          companies.value = jsonData.map((e) => Company.fromJson(e)).toList();
          box.write('companies', response.body);
          box.write('companies_last_fetch', now.toIso8601String());
        } else {
          print('فشل في الجلب من السيرفر. الرمز: ${response.statusCode}');
        }
      } catch (e) {
        print('فشل الاتصال بالسيرفر، سيتم استخدام البيانات المخزنة فقط. الخطأ: $e');
      }
    }

  }

}

