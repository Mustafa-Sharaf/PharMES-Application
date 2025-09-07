import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/modules/my_orders/show_order_Items.dart';
import '../../app_theme/app_colors.dart';
import '../demand_order/demand_order_controller.dart';
import 'my_orders_controller.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyOrdersController controller = Get.put(MyOrdersController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        title: Text("My_Orders".tr),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.orders.isEmpty) {
          return Center(child: Text("No_orders_found".tr));
        }
        return ListView.builder(
          itemCount: controller.orders.length,
          itemBuilder: (context, index) {
            final order = controller.orders[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: ListTile(
                  leading: Icon(
                    Icons.receipt_long,
                    size: 30,
                    color: AppColors.primaryColor,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order #${order.id}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Obx(() {
                        final repos =
                            Get.find<DemandOrderController>().repositories;
                        if (repos.isEmpty) {
                          return const Text("Loading repositories...");
                        }
                        final repo = repos.firstWhereOrNull(
                          (r) => r.id == order.repositoryId,
                        );
                        return Text("Repository: ${repo?.name ?? 'unknown'}");
                      }),

                      Text("Status: ${order.status}"),
                      Text("Paid: \$${order.paid}"),
                      Text("Remaining: \$${order.remaining}"),
                      Text("Total Price: \$${order.totalPrice}"),
                    ],
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == "view") {
                        Get.to(() => ShowOrderItems(order: order));
                      } else if (value == "edit") {
                        controller.updateOrderStatus(order.id, "canceled");
                      } else if (value == "delete") {
                        controller.deleteOrder(order.id);
                      } else if (value == "add") {
                        controller.addOrderToStock(order);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: "edit",
                        child: Center(child: Text("✏ Edit State")),
                      ),
                      PopupMenuItem(
                        value: "view",
                        child: Center(child: Text("👀view order")),
                      ),
                      PopupMenuItem(
                        value: "delete",
                        child: Center(child: Text("🗑 Delete order")),
                      ),
                      PopupMenuItem(
                        value: "add",
                        child: Center(child: Text("🏭 Add my stock")),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
