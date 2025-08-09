import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/medicine_card.dart';
import 'my_stock_controller.dart';
class MyStockScreen extends StatelessWidget {
  const MyStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyStockController controller = Get.put(MyStockController());
    return Scaffold(
      appBar: AppBar(title: Text("My Stock",style: TextStyle(color: Colors.white),),backgroundColor: AppColors.primaryColor,),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.value != null) {
          return Center(child: Text(controller.errorMessage.value!));
        }
        if (controller.stocks.isEmpty) {
          return const Center(child: Text('No data'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: controller.stocks.length,
          separatorBuilder: (_, __) =>  SizedBox(height: MediaQuery.of(context).size.width * 0.001,),
          itemBuilder: (context, index) {
            final stock = controller.stocks[index];
            final medicine = stock['medicine'] as Map<String, dynamic>? ?? {};

            return MedicineCard(
              stock: stock,
              medicine: medicine,
              showButton: false,
            );
          },
        );
      }),
    );
  }
}
