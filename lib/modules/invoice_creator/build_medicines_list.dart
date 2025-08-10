import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'invoice_creator_controller.dart';
import 'medicine_info_card.dart';
class BuildMedicinesList extends StatelessWidget {
  const BuildMedicinesList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InvoiceCreatorController());
    return  Expanded(
      child: ListView.separated(
        itemCount: controller.medicines.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, i) {
          final med = controller.medicines[i];
          return MedicineInfoCard(
            medicine: med,
            onIncrease: () => controller.increaseQuantity(i),
            onDecrease: () => controller.decreaseQuantity(i),
          );
        },
      ),
    );
  }
}
