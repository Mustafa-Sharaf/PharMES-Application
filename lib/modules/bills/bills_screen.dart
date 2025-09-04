import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import '../invoice_creator/invoice_creator_controller.dart';
import '../invoice_creator/invoice_creator_screen.dart';
import '../invoice_display/invoice_display_screen.dart';
import 'bills_controller.dart';
import '../my_stock/my_stock_controller.dart';
import '../bills/medicine.dart';
class BillsScreen extends StatelessWidget {
  BillsScreen({super.key});

  final BillsController controller = Get.put(BillsController());
  final MyStockController stockController= Get.find();
  final List<Widget> pages = [InvoiceCreatorScreen(), InvoiceDisplayScreen()];

  final isSearching = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(() {
          return AppBar(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            title: isSearching.value
                ? TextField(
                    autofocus: true,
                    style: const TextStyle(color: Colors.white),
                    decoration:  InputDecoration(
                      hintText: "search_here".tr,
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      stockController.searchQuery.value = value;
                    },
                  )
                :  Text(
                    "Bills_Management".tr,
                    style: TextStyle(color: Colors.white),
                  ),
            actions: [
              IconButton(
                icon: Icon(isSearching.value ? Icons.close : Icons.search),
                onPressed: () {
                  if (isSearching.value) {
                    stockController.searchQuery.value = '';
                  }
                  isSearching.toggle();
                },
              ),
            ],
          );
        }),
      ),

      body: Obx(() {
        if (isSearching.value && stockController.searchQuery.isNotEmpty) {
          return Column(
            children: [
              Container(
                color: Colors.grey.shade100,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: stockController.filteredStocks.length,
                  itemBuilder: (context, index) {
                    final stock = stockController.filteredStocks[index];
                    final medicine =
                        stock['medicine'] as Map<String, dynamic>? ?? {};
                    final name = medicine['trade_name'] ?? '';
                    return ListTile(
                      title: Text(name),
                      trailing: const Icon(Icons.add, color: AppColors.primaryColor),
                        onTap: () {
                          final invoiceController = Get.find<InvoiceCreatorController>();

                          invoiceController.addMedicine(
                            MedicineStock(
                              medicineId: stock['medicine_id'],
                              tradeName: medicine['trade_name'],
                              //scientificName: medicine['scientific_name'] ?? '',
                             // pharmaceuticalForm: medicine['pharmaceutical_form'] ?? '',
                              dosage: medicine['titer'] ?? '',
                              quantity: 1,
                              price: double.tryParse(stock['sale_price'].toString()) ?? 0.0,
                              batch: stock['batch'] ?? '',
                            ),
                          );

                          isSearching.value = false;
                          stockController.searchQuery.value = '';
                        }
                    );
                  },
                ),
              ),
            ],
          );
        }
        return pages[controller.selectedIndex.value];
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.grey,
          onTap: controller.changeTab,
          items:  [
            BottomNavigationBarItem(
              icon: Icon(Icons.remove_circle_outline),
              label: "Create_a_bill".tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.warning_amber),
              label: "Bills".tr,
            ),
          ],
        ),
      ),
    );
  }
}
