import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configurations/http_helpers.dart';
import 'all_users_model.dart';


class UsersController extends GetxController {
  var persons = <Users>[].obs;
  var isLoading = false.obs;

  final box = GetStorage();


  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    isLoading.value = true;

    final cachedData = box.read('users');
    if (cachedData != null) {
      try {
        List jsonData = json.decode(cachedData);
        persons.value = jsonData.map((e) => Users.fromJson(e)).toList();
      } catch (e) {
        print('خطأ في قراءة البيانات المخزنة: $e');
      }
    }


    final lastFetchTimeString = box.read('users_last_fetch');
    DateTime? lastFetchTime = lastFetchTimeString != null
        ? DateTime.tryParse(lastFetchTimeString)
        : null;
    final now = DateTime.now();
    final shouldFetchFromApi =
        lastFetchTime == null || now.difference(lastFetchTime).inHours >= 24;


    if (shouldFetchFromApi) {
      try {
        final response = await HttpHelper.gettData(url: 'getusers');
        if (response.statusCode == 200) {
          List jsonData = json.decode(response.body);
          persons.value = jsonData.map((e) => Users.fromJson(e)).toList();
          box.write('users', json.encode(jsonData));
          box.write('users_last_fetch', now.toIso8601String());
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

