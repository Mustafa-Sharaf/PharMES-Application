import 'package:flutter/material.dart';
import 'package:pharmes_app/widgets/rounded_text_field.dart';
import 'invoice_creator_controller.dart';
import 'package:get/get.dart';
class BuildNationalidField extends StatelessWidget {
  const BuildNationalidField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InvoiceCreatorController());
    return Padding(
      padding: const EdgeInsets.only(right: 6,left: 6),
      child: RoundedTextField(
        hintText: "ادخل الرقم الوطني",
        onChanged: (val) => controller.nationalId.value = val,
        keyboardType: TextInputType.number,
        maxLength: 11,
        showCounter: true,
        height: 50,
      ),
    );
  }}
