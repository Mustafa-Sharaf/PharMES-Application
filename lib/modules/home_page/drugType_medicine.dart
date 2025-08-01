import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import '../../widgets/build_flexible.dart';
import 'drugType_controller.dart';

class DrugTypeMedicine extends StatelessWidget {
  const DrugTypeMedicine({
    super.key,
    required this.formId,
    required this.formName,
  });

  final int formId;
  final String formName;

  @override
  Widget build(BuildContext context) {
    final DrugTypeController controller = Get.put(DrugTypeController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchDrugType(formId);
    });

    return Scaffold(
      backgroundColor: AppColors.backgroundHome,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        title: Text(formName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.drugTypeMedicine.isEmpty) {
            return const Center(
              child: Text("There are no medications for this type"),
            );
          }

          return ListView.builder(
            itemCount: controller.drugTypeMedicine.length,
            itemBuilder: (context, index) {
              final drugType = controller.drugTypeMedicine[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02,
                  right: MediaQuery.of(context).size.height * 0.01,
                  bottom: MediaQuery.of(context).size.height * 0.01,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BuildFlexible(
                              title: "Trade name: ",
                              text: drugType.tradeName,
                            ),
                            BuildFlexible(
                              title: "Titer: ",
                              text: drugType.titer,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BuildFlexible(
                              title: "Composition: ",
                              text: drugType.composition,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BuildFlexible(
                              title: "Company Name: ",
                              text: drugType.laboratory.nameEn,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: const Text("6000"),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: const Text("9000"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
