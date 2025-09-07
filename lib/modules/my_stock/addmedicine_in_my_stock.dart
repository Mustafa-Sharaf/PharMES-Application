import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import '../../app_theme/theme_controller.dart';
import '../../helpers/request_queue_manager.dart';
import '../../widgets/build_flexible.dart';
import '../home_page/medicine_content_controller.dart';
import 'addMedicineDialog.dart';


class AddMedicineInMyStock extends StatelessWidget {
  const AddMedicineInMyStock({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeContentController controller=Get.find();
    final ThemeController themeController = Get.find();
    return Scaffold(
      backgroundColor: themeController.isDarkMode.value?AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        title: Text(
          "Add_Medicine_In_My_Stock".tr,
          style: TextStyle(
            color: AppColors.white,
            fontSize: MediaQuery.of(context).size.width * 0.05,
          ),
        ),
      ),
      body:  Padding(
          padding: EdgeInsetsGeometry.all(12),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Search_by_name...".tr,
                  prefixIcon: Icon(Icons.search, color: themeController.isDarkMode.value?AppColors.backgroundDark :Colors.grey),
                  filled: true,
                  fillColor: themeController.isDarkMode.value?AppColors.componentDark :Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  controller.searchMedicines(value);
                },
              ),
              SizedBox(height: 12),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: controller.filteredMedicines.length,
                    itemBuilder: (context, index) {
                      final med = controller.filteredMedicines[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.02,
                          right: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: themeController.isDarkMode.value?AppColors.componentDark :Colors.white,
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
                                      title: "Trade_name".tr,
                                      text: med.tradeName,
                                    ),
                                    BuildFlexible(
                                      title: "Type".tr,
                                      text: med.pharmaceuticalForm,
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
                                      title: "Composition".tr,
                                      text: med.composition,
                                    ),
                                    BuildFlexible(
                                      title: "Titer".tr,
                                      text: med.titer,
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
                                      title: "Company_Name".tr,
                                      text: med.laboratory,
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
                                    SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * 0.04,
                                    ),
                                    ElevatedButton(
                                      onPressed: ()async {
                                        AddMedicineDialog(medicine: med).show(context);
                                        await RequestQueueManager.processQueue();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize:  Size(MediaQuery.of(context).size.width*0.077, MediaQuery.of(context).size.height*0.035),
                                        padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.017, vertical: MediaQuery.of(context).size.height*0.0018),
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        backgroundColor:  AppColors.primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Text(
                                         "💊➕" ,
                                        style:  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.037,),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * 0.04,
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
            ],
          ),
        ),
    );
  }
}
