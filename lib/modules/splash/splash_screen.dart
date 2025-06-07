import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import 'splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.put(SplashController());
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              width: controller.imageSize.value,
              height: controller.imageSize.value,
              curve: Curves.easeOutBack,
              child: Image.asset('assets/images/logo.jpg'),
            )),
            const SizedBox(width: 2),
            Obx(() => AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: controller.showText.value ? 1.0 : 0.0,
              child:  Text(
                'PharMes',
                style: TextStyle(fontSize: 33, color: AppColors.white,
                fontFamily: 'EduVIC'),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
