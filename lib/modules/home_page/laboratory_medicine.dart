import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../widgets/build_flexible.dart';
import 'laboratory_controller.dart';

class LaboratoryMedicine extends StatelessWidget {
  const LaboratoryMedicine({super.key,
  required this.laboratoryId,
    required this.laboratoryName,});

  final int laboratoryId;
  final String laboratoryName;
  @override
  Widget build(BuildContext context) {
    final LaboratoryController controller = Get.put(LaboratoryController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchLaboratory(laboratoryId);
    });
    return Scaffold(
      backgroundColor: AppColors.backgroundHome,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        title: Text(laboratoryName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.laboratoryModel.isEmpty) {
            return const Center(
              child: Text("There are no medications for this type"),
            );
          }
          return ListView.builder(
            itemCount: controller.laboratoryModel.length,
            itemBuilder: (context, index) {
              final laboratory = controller.laboratoryModel[index];
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
                              text: laboratory.tradeName,
                            ),
                            BuildFlexible(
                              title: "Titer: ",
                              text: laboratory.titer,
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
                              text: laboratory.composition,
                            ),
                            BuildFlexible(
                              title: "Type: ",
                              text: laboratory.pharmaceuticalForm.nameEn,
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
