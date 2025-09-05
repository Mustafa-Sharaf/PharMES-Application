import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/modules/expired_medicines/expired_medicines_controller.dart';
import '../../widgets/medicine_card.dart';
import '../demand_order/demand_order.dart';
class ExpiredMedicinesScreen extends StatelessWidget {
  const ExpiredMedicinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ExpiredMedicinesController controller = Get.put(ExpiredMedicinesController());
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.value != null) {
          return Center(child: Text(controller.errorMessage.value!));
        }
        if (controller.stocks.isEmpty) {
          return  Center(child: Text('No_data'.tr));
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
              highlightField: 'expires'.tr,
              icon: 'expired',
             showButton: true,
             onButtonPressed: () {
               showAddOrderDialog(context, medicine);
             },
            );
          },
        );
      }),
    );
  }
}
