import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import '../../language/language_controller.dart';
import '../../widgets/Build_drug_type.dart';
import '../../widgets/build_Companies.dart';
import '../../widgets/build_flexible.dart';
import 'companies_controller.dart';
import 'drugType_medicine.dart';
import 'forms_controller.dart';
import 'laboratory_medicine.dart';
import 'medicine_content_controller.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeContentController());
    final companiesController = Get.put(CompaniesController());
    final formsController = Get.put(FormsController());
    final languageController = Get.find<MyLanguageController>();
    return Scaffold(
      backgroundColor: AppColors.backgroundHome,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
              right: MediaQuery.of(context).size.height * 0.02,
              top: MediaQuery.of(context).size.height * 0.01,
            ),
            child: Text(
              "Companies".tr,
              style: TextStyle(
                fontSize: MediaQuery.textScalerOf(context).scale(18),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Obx(() {
            final langCode =
                languageController.intiaLanguage.value.languageCode;
            final companies = companiesController.companies;
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.13,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: companies.length,
                itemBuilder: (context, index) {
                  final company = companies[index];
                  final title = langCode == 'ar'
                      ? company.nameAr
                      : company.nameEn;
                  return GestureDetector(
                    onTap:() {
                      Get.to(()=>LaboratoryMedicine(laboratoryId:company.id,laboratoryName:title ,));
                    },
                    child: BuildCompanies(image: company.image, title: title),
                  );
                },
              ),
            );
          }),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
              right: MediaQuery.of(context).size.height * 0.02,
            ),
            child: Text(
              "Drug_Types".tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: Obx(() {
              final langCode =
                  languageController.intiaLanguage.value.languageCode;
              final forms = formsController.forms;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: forms.length,
                itemBuilder: (context, index) {
                  final form = forms[index];
                  final title = langCode == 'ar' ? form.nameAr : form.nameEn;
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        () =>
                            DrugTypeMedicine(formId: form.id, formName: title),
                      );
                    },
                    child: BuildDrugType(image: form.image, titleType: title),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
              right: MediaQuery.of(context).size.height * 0.02,
              top: MediaQuery.of(context).size.height * 0.02,
            ),
            child: Text(
              "View_All".tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: controller.medicines.length,
                itemBuilder: (context, index) {
                  final med = controller.medicines[index];
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
                                  text: med.tradeName,
                                ),
                                BuildFlexible(
                                  title: "Type: ",
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
                                  title: "Composition: ",
                                  text: med.composition,
                                ),
                                BuildFlexible(
                                  title: "Titer: ",
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
                                  title: "Company Name: ",
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
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
