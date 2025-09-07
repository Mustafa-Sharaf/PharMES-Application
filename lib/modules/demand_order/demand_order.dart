import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/build_flexible.dart';
import '../cart/cart_controller.dart';
import 'DemandOrderModel.dart';
import 'demand_order_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';

void showAddOrderDialog(BuildContext context, Map<String, dynamic> medicine) {
  final controller = Get.find<DemandOrderController>();
  controller.loadRepositories();

  final TextEditingController qtyController = TextEditingController();

  Get.dialog(
    AlertDialog(
      title: Center(child: Text("Add_Order".tr)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildFlexible(
            title: "Trade_name".tr,
            text: medicine['trade_name'] ?? '',
          ),
          SizedBox(height: 10),
          BuildFlexible(title: "Titer".tr, text: medicine['titer'] ?? ''),
          SizedBox(height: 10),
          Obx(
            () => DropdownSearch<String>(
              items: controller.repositories.map((repo) => repo.name).toList(),
              selectedItem: controller.selectedRepositoryName.value.isEmpty
                  ? null
                  : controller.selectedRepositoryName.value,
              popupProps: PopupProps.menu(
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    hintText: "Search Repository",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  hintText: "Select_Repository".tr,
                  prefixIcon: Icon(Icons.warehouse, color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onChanged: (val) {
                controller.selectedRepositoryName.value = val ?? "";

                final selectedRepo = controller.repositories.firstWhere(
                  (r) => r.name == val,
                );
                controller.selectedRepositoryId.value = selectedRepo.id;
                final cartController = Get.find<CartController>();
                cartController.selectRepository(selectedRepo.id);
              },
            ),
          ),

          SizedBox(height: 10),
          TextField(
            controller: qtyController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Quantity".tr,
              labelStyle: TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: Icon(Icons.confirmation_num, color: Colors.grey),
            ),
            cursorColor: AppColors.primaryColor,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: AppColors.primaryColor,
                    width: 0.5,
                  ),
                  foregroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                ),
                child: Text("Cancel".tr, textAlign: TextAlign.center),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (controller.selectedRepositoryId.value != null &&
                      qtyController.text.isNotEmpty) {
                    final box = GetStorage();
                    final cartController = Get.find<CartController>();
                    final pharmacyId = box.read("pharmacy_id") ?? 0;
                    print(
                      "medicine['id']-----------------------------${medicine['id']}",
                    );
                    print(
                      "controller.selectedRepositoryId.value------------------${controller.selectedRepositoryId.value!}",
                    );
                    final newOrder = DemandOrderModel(
                      id: medicine['id'] ?? 0,
                      pharmacyId: pharmacyId,
                      repositoryId: controller.selectedRepositoryId.value!,
                      tradeName: medicine['trade_name'] ?? '',
                      titer: medicine['titer'] ?? '',
                      quantity: int.parse(qtyController.text),
                    );

                    cartController.addOrder(newOrder);
                    Get.back();
                  } else {
                    Get.snackbar("خطأ", "الرجاء اختيار مستودع وكمية");
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                ),
                child: Text("Save".tr, textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
