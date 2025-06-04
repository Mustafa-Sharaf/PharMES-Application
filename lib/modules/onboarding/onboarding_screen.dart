// lib/modules/onboarding/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import 'onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFFEEF0F3),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0),
              child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  controller.onboardingData.length,
                      (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 10,
                    height: 10,
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
              height: 300,
            )),

            const SizedBox(height: 30),

            Obx(() => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                controller.onboardingData[controller.currentPage.value]['text']!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            )),

            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: ElevatedButton(
                  onPressed: controller.nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 12),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min,
                    children: [

                      const Text(
                        'Next',
                        style: TextStyle(color: AppColors.black, fontSize: 15),
                      ),
                      SizedBox(width: 5,),
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
