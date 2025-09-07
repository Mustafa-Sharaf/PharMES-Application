import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../configurations/http_helpers.dart';
import '../my_stock/my_stock_controller.dart';
import 'my_orders_model.dart';
import '../../app_theme/app_colors.dart';


class MyOrdersController extends GetxController {
  var orders = <MyOrdersModel>[].obs;
  var isLoading = false.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    isLoading.value = true;

    try {
      final response = await HttpHelper.gettData(url: 'Pharmacy/Order/my-Order');
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        orders.value = data.map((e) => MyOrdersModel.fromJson(e)).toList();

        box.write('my_orders', data);
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
    final cachedData = box.read('my_orders');
    if (cachedData != null) {
      try {
        orders.value = (cachedData as List)
            .map((e) => MyOrdersModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
        print(' تم تحميل البيانات من الكاش');
      } catch (e) {
        print('خطأ في قراءة البيانات من الكاش: $e');
      }
    } else {
      print('لا يوجد بيانات مخزنة في الكاش');
    }
  }

  void showOrderItems(MyOrdersModel order) {
    Get.defaultDialog(
      title: "Order Items",
      content: Column(
        children: order.items
            .map(
              (e) => ListTile(
            title: Text(e.medicine.tradeName),
            subtitle: Text("Batch: ${e.batch} | Exp: ${e.expirationDate}"),
            trailing: Text("Qty: ${e.quantity}"),
          ),
        )
            .toList(),
      ),
      textConfirm: "Close",
      onConfirm: () => Get.back(),
      confirmTextColor: Colors.white,
      buttonColor: AppColors.primaryColor,
    );
  }

  Future<void> updateOrderStatus(int orderId, String newStatus) async {
    try {
      final orderIndex = orders.indexWhere((o) => o.id == orderId);
      if (orderIndex == -1) {
        Get.snackbar(
          "Error",
          "The order does not exist",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      final order = orders[orderIndex];

      if (order.status.toLowerCase() != "pending") {
        Get.snackbar(
          "Error",
          "The status can only be modified if: Pending",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      isLoading.value = true;

      final response = await HttpHelper.postData(
        url: "Pharmacy/Order/updateOrderStatus/$orderId",
        body: {
          "status": newStatus,
        },
      );

      if (response.statusCode == 200) {
        final updatedOrder = order.copyWith(status: newStatus);
        orders[orderIndex] = updatedOrder;
        orders.refresh();
        Get.snackbar(
          "success",
          "The order status has been modified successfully",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "fail",
          "Status not modified Code: ${response.statusCode}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("حدث خطأ: $e");
    } finally {
      isLoading.value = false;
    }
  }



  Future<void> deleteOrder(int orderId) async {
    try {
      final orderIndex = orders.indexWhere((o) => o.id == orderId);

      if (orderIndex == -1) {
        Get.snackbar(
          "Error",
          "The order does not exist",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      final order = orders[orderIndex];

      if (!(order.status.toLowerCase() == "canceled" ||
          order.status.toLowerCase() == "delivered" ||
          order.status.toLowerCase() == "rejected")) {
        Get.snackbar(
          "تنبيه",
          "It can only be deleted if the status is Cancelled, Delivered, or Rejected",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      isLoading.value = true;
      final response = await HttpHelper.postData(
        url: "Pharmacy/Order/delete-order/$orderId",
      );

      if (response.statusCode == 200) {
        orders.removeAt(orderIndex);

        Get.snackbar(
          "success",
          "The request was successfully deleted",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "fail",
          "Not deleted Code: ${response.statusCode}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("حدث خطأ أثناء الحذف: $e");

    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addOrderToStock(MyOrdersModel order) async {
    try {
      if (order.status.toLowerCase() != "delivered") {
        Get.snackbar(
          "alert",
           "The invoice can only be added to inventory if it is Delivered",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      isLoading.value = true;

      final List<Map<String, dynamic>> items = order.items.map((item) {
        return {
          "medicine_id": item.medicineId,
          "pharmacy_id": order.repositoryId,
          "batch": (item.batch?.isNotEmpty == true) ? item.batch : "BATCH-${DateTime.now().millisecondsSinceEpoch}",
          "expiration_date": (item.expirationDate?.isNotEmpty == true) ? item.expirationDate : "2026-12-31",
          "quantity": item.quantity,
          "Purchase_price": double.tryParse(item.purchasePrice ?? "0.00") ?? 0.0,
          "sale_price": 0.0,
        };
      }).toList();

      final body = {
        "items": items,
      };

      final response = await HttpHelper.postJson(
        url: "Pharmacy/pharmacy-stocks/add-medicines",
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          "success",
          "All invoice items have been added to your inventory",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.find<MyStockController>().fetchStocks();
      } else {
        print("Response: ${response.body}");
        Get.snackbar(
          "fail",
          "Failed to add items: ${response.body}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("حدث خطأ أثناء الإضافة: $e");


    } finally {
      isLoading.value = false;
    }
  }



}
