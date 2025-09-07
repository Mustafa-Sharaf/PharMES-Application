import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configurations/http_helpers.dart';
import '../demand_order/DemandOrderModel.dart';
import '../demand_order/demand_order_model.dart';
import 'order_Item_model.dart';



class CartController extends GetxController {
  var repositories = <RepositoryModel>[].obs;
  var orders = <DemandOrderModel>[].obs;
  var selectedRepositoryId = Rxn<int>();
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchRepositories();
  }

  void selectRepository(int id) {
    selectedRepositoryId.value = id;
  }

  List<DemandOrderModel> getOrdersByRepository(int repositoryId) {
    return orders.where((o) => o.repositoryId == repositoryId).toList();
  }

  void updateOrderQuantity(DemandOrderModel order, int newQty) {
    final index = orders.indexOf(order);
    if (index != -1) {
      orders[index] = DemandOrderModel(
        id: order.id,
        pharmacyId: order.pharmacyId,
        repositoryId: order.repositoryId,
        tradeName: order.tradeName,
        titer: order.titer,
        quantity: newQty,
      );
      orders.refresh();
    }
  }

  void deleteOrder(DemandOrderModel order) {
    orders.remove(order);
    orders.refresh();
  }
  void addOrder(DemandOrderModel order) {
    orders.add(order);
  }

  Future<void> fetchRepositories() async {
    final cachedData = box.read('repositories');
    if (cachedData != null) {
      try {
        List jsonData = json.decode(cachedData);
        repositories.value = jsonData
            .map((e) => RepositoryModel.fromJson(e))
            .toList();
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
        lastFetchTime == null || now
            .difference(lastFetchTime)
            .inHours >= 24;

    if (shouldFetchFromApi) {
      try {
        final response = await HttpHelper.gettData(url: 'repositories');
        if (response.statusCode == 200) {
          List jsonData = json.decode(response.body);
          repositories.value = jsonData
              .map((e) => RepositoryModel.fromJson(e))
              .toList();
          box.write('repositories', json.encode(jsonData));
          box.write('repositories_last_fetch', now.toIso8601String());
        } else {
          print('فشل في الجلب من السيرفر. الرمز: ${response.statusCode}');
        }
      } catch (e) {
        print(
          'فشل الاتصال بالسيرفر، سيتم استخدام البيانات المخزنة فقط. الخطأ: $e',
        );
      }
    }
  }


  Future<void> sendOrder(int repositoryId) async {
    final box = GetStorage();
    final userId = box.read("user_id") ?? 0;
    final pharmacyId = box.read("pharmacy_id") ?? 0;

    final repoOrders = getOrdersByRepository(repositoryId);

    if (repoOrders.isEmpty) {
      Get.snackbar("Error", "There are no requests to send");
      return;
    }

    final items = repoOrders.map((order) {
      return DemandOrderItem(
        medicineId: order.id,
        quantity: order.quantity,
      );
    }).toList();

    final newOrder = DemandOrderRequest(
      userId: userId,
      pharmacyId: pharmacyId,
      repositoryId:repositoryId,
      orderNum: DateTime.now().millisecondsSinceEpoch % 100000,
      items: items,
    );

    try {
      final response = await HttpHelper.postJson(
        url: "Pharmacy/Order/demand-Order",
        body: newOrder.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
            "success",
            "The request has been sent successfully",
            backgroundColor: Colors.green,
             );
        orders.removeWhere((o) => o.repositoryId == repositoryId);
        orders.refresh();
      } else {
        print("Error sending order: ${response.body}");
      }
    } catch (e) {
      print("Error sending order: $e");
    }
  }
}



