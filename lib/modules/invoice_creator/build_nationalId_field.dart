/*
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
*/
/*
import 'package:flutter/material.dart';
import 'package:pharmes_app/widgets/rounded_text_field.dart';
import '../invoice_creator/invoice_creator_controller.dart';
import 'package:get/get.dart';

import 'customer_invoice.dart';

class BuildNationalidField extends StatelessWidget {
  final CustomerInvoice invoice; // <--- خليه ياخذ الفاتورة الحالية
  const BuildNationalidField({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6, left: 6),
      child: Obx(() => RoundedTextField(
        hintText: "ادخل الرقم الوطني",
        onChanged: (val) => invoice.nationalId.value = val,
        keyboardType: TextInputType.number,
        maxLength: 11,
        showCounter: true,
        height: 50,
        controller: null, // إذا تحتاج تتحكم بالـ TextEditingController خاص بالـ invoice ممكن تضيفه
      )),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:pharmes_app/widgets/rounded_text_field.dart';
import 'package:get/get.dart';

import 'customer_invoice.dart';

class BuildNationalidField extends StatelessWidget {
  final CustomerInvoice invoice; // <--- بياخد الفاتورة الحالية
  const BuildNationalidField({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: invoice.nationalId.value);

    return Padding(
      padding: const EdgeInsets.only(right: 6, left: 6),
      child: RoundedTextField(
        hintText: "ادخل الرقم الوطني",
        controller: controller,
        onChanged: (val) => invoice.nationalId.value = val,
        keyboardType: TextInputType.number,
        maxLength: 11,
        showCounter: true,
        height: 50,
      ),
    );
  }
}
