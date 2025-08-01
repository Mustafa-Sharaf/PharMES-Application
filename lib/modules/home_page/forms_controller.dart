import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configurations/http_helpers.dart';
import '../../language/language_controller.dart';
import 'forms_model.dart';

class FormsController extends GetxController {
  var forms = <Forms>[].obs;
  var isLoading = false.obs;
  final MyLanguageController languageController = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchForms();
  }

  Future<void> fetchForms() async {
    final box = GetStorage();

    final cachedData = box.read('forms');
    if (cachedData != null) {
      try {
        List jsonData = json.decode(cachedData);
        forms.value = jsonData.map((e) => Forms.fromJson(e)).toList();
      } catch (e) {
        print('خطأ في قراءة البيانات المخزنة: $e');
      }
    }
    final lastFetchTimeString = box.read('forms_last_fetch');
    DateTime? lastFetchTime = lastFetchTimeString != null ? DateTime.tryParse(lastFetchTimeString) : null;
    final now = DateTime.now();

    final shouldFetchFromApi = lastFetchTime == null || now.difference(lastFetchTime).inHours >= 24;
    if (shouldFetchFromApi) {
    try {
      final response = await HttpHelper.gettData(url: 'getforms');
      if (response.statusCode == 200) {
        List jsonData = json.decode(response.body);
        forms.value = jsonData.map((e) => Forms.fromJson(e)).toList();
        box.write('forms', response.body);
        box.write('forms_last_fetch', now.toIso8601String());
      }
    } catch (e) {
      print('Exception: $e');
    }
    }
  }
}
