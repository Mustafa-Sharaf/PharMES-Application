// lib/modules/onboarding/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import 'onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.only( left:screenWidth * 0.04),
              child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  controller.onboardingData.length,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                        width: screenWidth * 0.025,
                        height: screenWidth * 0.025,
                    decoration: BoxDecoration(
                      color: controller.currentPage.value == index
                          ? AppColors.primaryColor
                          : AppColors.Gray,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              )),
            ),
            const SizedBox(height: 50),
            Obx(() => Image.asset(
              controller.onboardingData[controller.currentPage.value]['image']!,
              height: screenHeight * 0.4,
            )),

            const SizedBox(height: 30),

            Obx(() => Padding(
              padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Text(
                controller.onboardingData[controller.currentPage.value]['text']!,
                style:  TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            )),

            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.06),
                child: ElevatedButton(
                  onPressed: controller.nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.09,
                      vertical: screenHeight * 0.015,),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min,
                    children: [
                       Text(
                        'Next'.tr,
                        style: TextStyle(color: AppColors.black, fontSize: 15),
                      ),
                      SizedBox(width: screenWidth * 0.02,),
                      Icon(Icons.arrow_forward,color: AppColors.black,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
