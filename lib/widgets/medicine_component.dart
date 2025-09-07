import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_theme/app_colors.dart';
import '../app_theme/theme_controller.dart';
import 'build_flexible.dart';

class MedicineComponent extends StatelessWidget {
  const MedicineComponent({super.key,required this.med});
  final  med;

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
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
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text("6000"),
                  ),
                  SizedBox(
                    width:
                    MediaQuery.of(context).size.width * 0.02,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text("9000"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
