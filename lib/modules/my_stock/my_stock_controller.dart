import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configurations/http_helpers.dart';




class MyStockController extends GetxController {
  var stocks = <Map<String, dynamic>>[].obs;
  var filteredStocks = <Map<String, dynamic>>[].obs;
  var searchQuery = ''.obs;
  var isLoading = false.obs;
  var errorMessage = RxnString();
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    fetchStocks();
    ever(searchQuery, (_) => filterStocks());
    //RequestQueueManager.processQueue();
  }

  Future<void> fetchStocks() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      final token = box.read<String>('token');
      print('Token used: $token');
      final res = await HttpHelper.gettData(url: 'Pharmacy/pharmacy-stocks');
      if (res.statusCode == 200 || res.statusCode == 201) {
        final body = jsonDecode(res.body);
        if (body['data'] != null) {
          print(res.body);
          final List list = body['data'];
          stocks.value = List<Map<String, dynamic>>.from(list);
        } else {
          print(res.body);
          errorMessage.value = 'No data';
        }
      }
      else if(res.statusCode == 500) {
        Get.offNamed('/signIn');
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
  void filterStocks() {
    final query = searchQuery.value.toLowerCase();
    if (query.isEmpty) {
      filteredStocks.value = stocks;
    } else {
      filteredStocks.value = stocks.where((stock) {
        final medicine = stock['medicine'] as Map<String, dynamic>? ?? {};
        final tradeName = (medicine['trade_name'] ?? '').toString().toLowerCase();
        return tradeName.startsWith(query);
      }).toList();
    }
  }
}

