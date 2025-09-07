import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import 'actions_buttons.dart';
import 'build_customer_row.dart';
import 'build_medicines_list.dart';
import 'build_nationalId_field.dart';
import 'custom_tabBar_appBar.dart';
import 'invoice_creator_controller.dart';
import 'medication-info_row.dart';

class InvoiceCreatorScreen extends StatelessWidget {
  const InvoiceCreatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InvoiceCreatorController>();

    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: CustomerTabsAppBar(
            indicatorColor: AppColors.primaryColor,
            onTabChanged: (index) {
              controller.changeTab(index);
            },
          ),
        ),
        body: Obx(() {
          final invoice = controller.currentInvoice;

          return ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BuildCustomerRow(invoice: invoice),

                  if (invoice.isPsychotropic.value)
                    BuildNationalidField(invoice: invoice),

                  const SizedBox(height: 12),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.46,
                    child: BuildMedicinesList(invoice: invoice),
                  ),

                  const SizedBox(height: 12),

                  MedicationInfoRow(
                    isPsychotropic: invoice.isPsychotropic,
                    customerNameEditing: invoice.customerNameEditing,
                    nationalId: invoice.nationalId,
                    total: invoice.total,
                    onPsychotropicChanged: (val) {
                      invoice.isPsychotropic.value = val ?? false;
                      if (val == false) {
                        invoice.customerNameEditing.value = "";
                        invoice.nationalId.value = "";
                      }
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ActionsButtons(
                  onSave: () => controller.saveInvoice(invoice),
                  onCancel: () => controller.cancelInvoice(invoice),
                  onPrint: () => controller.printInvoice(invoice),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}





/*
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
    final controller = Get.find<InvoiceCreatorController>();

    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: CustomerTabsAppBar(
            indicatorColor: AppColors.primaryColor,
            onTabChanged: (index) {
              controller.changeTab(index);
            },
          ),
        ),
        body: Obx(() {
          int i = controller.selectedTab.value;
          final invoice = controller.currentInvoice;
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BuildCustomerRow(invoice: invoice),
                  if (invoice.isPsychotropic.value)
                    BuildNationalidField(invoice: invoice),
                  const SizedBox(height: 12),
                  //Expanded(child: BuildMedicinesList(invoice: invoice)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4, // أو MediaQuery.of(context).size.height * 0.4
                    child: BuildMedicinesList(invoice: invoice),
                  ),
                  MedicationInfoRow(
                    isPsychotropic: invoice.isPsychotropic,
                    customerNameEditing: invoice.customerNameEditing,
                    nationalId: invoice.nationalId,
                    total: invoice.total,
                    onPsychotropicChanged: (val) {
                      invoice.isPsychotropic.value = val ?? false;
                      if (val == false) {
                        invoice.customerNameEditing.value = "";
                        invoice.nationalId.value = "";
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  ActionsButtons(
                    onSave: () =>
                        controller.saveInvoice(controller.currentInvoice),
                    onCancel: () =>
                        controller.cancelInvoice(controller.currentInvoice),
                    onPrint: () =>
                        controller.printInvoice(controller.currentInvoice),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
*/

/* isPsychotropic: controller.isPsychotropic,
                  customerNameEditing: controller.customerNameEditing,
                  nationalId: controller.nationalId,
                  total: controller.total,*/
/*if (controller.isPsychotropic.value) BuildNationalidField(),
                const SizedBox(height: 12),
                BuildMedicinesList(),*/
/* ActionsButtons(
                  onSave: controller.save,
                  onCancel: controller.cancel,
                  onPrint: controller.printInvoice,
                ),*/

/*CustomerTabsAppBar(
            indicatorColor: AppColors.primaryColor,
            onTabChanged: (index) {
              controller.selectedTab.value = index;
              controller.customerName.value = "زبون ${index + 1}";
              controller.invoiceNumber.value = 0 + index + 1;
              controller.isPsychotropic.value = false;
              controller.nationalId.value = "";
              controller.customerNameEditing.value = "";
            },
          ),*/
