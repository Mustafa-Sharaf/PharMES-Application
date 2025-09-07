/*
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configurations/http_helpers.dart';
class MissingController extends GetxController {
  var stocks = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var errorMessage = RxnString();
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    fetchStocks();
  }
  Future<void> fetchStocks() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      final token = box.read<String>('token');
      print(' Token used: $token');
      final res = await HttpHelper.gettData(url: 'Pharmacy/pharmacy-stocks/lowStock');
      if (res.statusCode == 200 || res.statusCode == 201) {
        final body = jsonDecode(res.body);
        if (body['data'] != null) {
          final List list = body['data'];
          stocks.value = List<Map<String, dynamic>>.from(list);
        }
        else {
          print(res.body);
          errorMessage.value = 'No data';
        }
      }
      else if (res.statusCode == 401) {
        box.erase();
        Get.offNamed('/signIn');
      }
      else if (res.statusCode == 403) {
        print("You are not able to access this page.");
      }
      else if (res.statusCode == 500) {
        print("Internal Server Error. Please try again later");
    }
    else {
        errorMessage.value = ' Faild : ${res.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
*/
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configurations/http_helpers.dart';

class MissingController extends GetxController {
  var stocks = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var errorMessage = RxnString();
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchStocks();
  }

  Future<void> fetchStocks() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      final token = box.read<String>('token');
      print(' Token used: $token');

      final res = await HttpHelper.gettData(
        url: 'Pharmacy/pharmacy-stocks/lowStock',
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        final body = jsonDecode(res.body);

        if (body['data'] != null) {
          final List list = body['data'];

          // ✅ تصفية الأدوية بحيث ما تنزل الكمية = صفر
          final filtered = list
              .where((item) => (item['quantity'] ?? 0) > 0)
              .map((e) => Map<String, dynamic>.from(e))
              .toList();

          stocks.assignAll(filtered);
        } else {
          print(res.body);
          errorMessage.value = 'No data';
        }
      } else if (res.statusCode == 401) {
        box.erase();
        Get.offNamed('/signIn');
      } else if (res.statusCode == 403) {
        print("You are not able to access this page.");
      } else if (res.statusCode == 500) {
        print("Internal Server Error. Please try again later");
      } else {
        errorMessage.value = ' Faild : ${res.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
