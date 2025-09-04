import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/build_flexible.dart';
import '../my_stock/my_stock_controller.dart';

class InventoryByName extends StatelessWidget {
  const InventoryByName({super.key});

  @override
  Widget build(BuildContext context) {
    final MyStockController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        title:  Text("Inventory_By_Name".tr, style: TextStyle(fontSize: 22)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search_for_the_medicine_name".tr,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onChanged: (value) {
                controller.searchQuery.value = value;
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage.value != null) {
                return Center(child: Text(controller.errorMessage.value!));
              }

              if (controller.filteredStocks.isEmpty) {
                return  Center(child: Text("No_results".tr));
              }
              return ListView.builder(
                itemCount: controller.filteredStocks.length,
                itemBuilder: (context, index) {
                  final stock = controller.filteredStocks[index];
                  final medicine =
                      stock['medicine'] as Map<String, dynamic>? ?? {};
                  return Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.medication,
                            color: AppColors.primaryColor,
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  BuildFlexible(
                                    title: "Trade_name".tr,
                                    text: medicine['trade_name'] ?? '',
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  BuildFlexible(
                                    title: "Titer".tr,
                                    text: medicine['titer'] ?? '',
                                  ),
                                ],
                              ),
                            ],
                          ),
                          subtitle: Text(
                            "${'Quantity'.tr} ${stock['quantity'] ?? ''}",
                            // "Quantity: ${stock['quantity'] ?? ''}",
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
