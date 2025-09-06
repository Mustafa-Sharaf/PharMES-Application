import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import 'cart_controller.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.repositories.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          title: Text("Cart".tr),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Obx(
              () => Container(
                color: Colors.white,
                child: TabBar(
                  isScrollable: true,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 3,
                      color: AppColors.primaryColor,
                    ),
                    insets: EdgeInsets.symmetric(horizontal: 16),
                  ),
                  labelColor: AppColors.primaryColor,
                  unselectedLabelColor: Colors.black54,
                  tabs: controller.repositories
                      .map((repo) => Tab(text: repo.name))
                      .toList(),
                  onTap: (index) {
                    final repo = controller.repositories[index];
                    controller.selectRepository(repo.id);
                  },
                ),
              ),
            ),
          ),
        ),
        body: Obx(
          () => TabBarView(
            children: controller.repositories.map((repo) {
              final repoOrders = controller.getOrdersByRepository(repo.id);

              return Column(
                children: [
                  Expanded(
                    child: repoOrders.isEmpty
                        ? Center(
                            child: Text(
                              "There_are_no_requests_for_this_warehouse".tr,
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.all(8),
                            itemCount: repoOrders.length,
                            separatorBuilder: (_, __) => const Divider(),
                            itemBuilder: (context, index) {
                              final order = repoOrders[index];
                              final qtyController = TextEditingController(
                                text: order.quantity.toString(),
                              );
                              return ListTile(
                                title: Text("Trade name: ${order.tradeName}"),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Titer: ${order.titer}"),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text("Quantity:"),
                                        SizedBox(
                                          width: 40,
                                          child: TextField(
                                            controller: qtyController,
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              isDense: true,
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                            onSubmitted: (value) {
                                              final newQty =
                                                  int.tryParse(value) ??
                                                  order.quantity;
                                              controller.updateOrderQuantity(
                                                order,
                                                newQty,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    controller.deleteOrder(order);
                                  },
                                ),
                              );
                            },
                          ),
                  ),
                  if (repoOrders.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        onPressed: () => controller.sendOrder(repo.id),
                        icon: Icon(Icons.send, color: Colors.white),
                        label: Text(
                          "Send Order",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 20,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
