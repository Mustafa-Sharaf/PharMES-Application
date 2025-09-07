import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configurations/http_helpers.dart';
import 'demand_order_model.dart';
class DemandOrderController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var repositories = <RepositoryModel>[].obs;
  var selectedRepositoryId = Rxn<int>();
  var selectedRepositoryName = "".obs;

  final box = GetStorage();

    Future<void> loadRepositories() async {
      isLoading.value = true;

      final cachedData = box.read('repositories');
      if (cachedData != null) {
        try {
          List jsonData = json.decode(cachedData);
          repositories.value =
              jsonData.map((e) => RepositoryModel.fromJson(e)).toList();
        } catch (e) {
          print('خطأ في قراءة البيانات المخزنة: $e');
        }
      }

      final lastFetchTimeString = box.read('repositories_last_fetch');
      DateTime? lastFetchTime = lastFetchTimeString != null
          ? DateTime.tryParse(lastFetchTimeString)
          : null;
      final now = DateTime.now();
      final shouldFetchFromApi =
          lastFetchTime == null || now.difference(lastFetchTime).inHours >= 24;

      if (shouldFetchFromApi) {
        try {
          final response = await HttpHelper.gettData(url: 'repositories');
          if (response.statusCode == 200) {
            List jsonData = json.decode(response.body);
            repositories.value =
                jsonData.map((e) => RepositoryModel.fromJson(e)).toList();
            box.write('repositories', json.encode(jsonData));
            box.write('repositories_last_fetch', now.toIso8601String());
          } else {
            print('فشل في الجلب من السيرفر. الرمز: ${response.statusCode}');
          }
        } catch (e) {
          print(
              'فشل الاتصال بالسيرفر، سيتم استخدام البيانات المخزنة فقط. الخطأ: $e');
        }
      }

      isLoading.value = false;
    }

  }
