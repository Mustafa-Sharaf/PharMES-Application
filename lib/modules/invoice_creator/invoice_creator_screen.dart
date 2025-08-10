import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/modules/invoice_creator/medication-info_row.dart';
import '../../app_theme/app_colors.dart';
import 'actions_buttons.dart';
import 'build_customer_row.dart';
import 'build_medicines_list.dart';
import 'build_nationalId_field.dart';
import 'custom_tabBar_appBar.dart';
import 'invoice_creator_controller.dart';

class InvoiceCreatorScreen extends StatelessWidget {
  const InvoiceCreatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InvoiceCreatorController());

    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: CustomerTabsAppBar(
            indicatorColor: AppColors.primaryColor,
            onTabChanged: (index) {
              controller.selectedTab.value = index;
              controller.customerName.value = "زبون ${index + 1}";
              controller.invoiceNumber.value = 0 + index + 1;
              controller.isPsychotropic.value = false;
              controller.nationalId.value = "";
              controller.customerNameEditing.value = "";
            },
          ),
        ),
        body: Obx(() {
          int i = controller.selectedTab.value;
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                BuildCustomerRow(),
                if (controller.isPsychotropic.value) BuildNationalidField(),
                const SizedBox(height: 12),
                BuildMedicinesList(),
                MedicationInfoRow(
                  isPsychotropic: controller.isPsychotropic,
                  customerNameEditing: controller.customerNameEditing,
                  nationalId: controller.nationalId,
                  total: controller.total,
                  onPsychotropicChanged: (val) {
                    controller.isPsychotropic.value = val ?? false;
                    if (val == false) {
                      controller.customerNameEditing.value = "";
                      controller.nationalId.value = "";
                    }
                  },
                ),
                const SizedBox(height: 8),
                ActionsButtons(
                  onSave: controller.save,
                  onCancel: controller.cancel,
                  onPrint: controller.printInvoice,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
  }

