import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/widgets/rounded_text_field.dart';
import 'invoice_creator_controller.dart';

class BuildCustomerRow extends StatelessWidget {
  const BuildCustomerRow({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InvoiceCreatorController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        controller.isPsychotropic.value
            ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8.0,
                    right: 6,
                    left: 6,
                  ),
                  child: RoundedTextField(
                    hintText: controller.customerName.value,
                    onChanged: (val) =>
                        controller.customerNameEditing.value = val,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    height: 45,
                  ),
                ),
              )
            : Text(
                "الزبون: ${controller.customerName.value}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
        Text(
          "رقم الفاتورة: ${controller.invoiceNumber.value}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
