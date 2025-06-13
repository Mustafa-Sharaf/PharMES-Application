// lib/modules/onboarding/onboarding_controller.dart
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/2.png',
      'text': "onboarding1".tr,
    },
    {
      'image': 'assets/images/1.png',
      'text': "onboarding2".tr,
    },
    {
      'image': 'assets/images/Web search-rafiki.png',
      'text': "onboarding3".tr,
    },
  ];

  void nextPage() {
    if (currentPage.value < onboardingData.length - 1) {
      currentPage.value++;
    } else {
      Get.offAllNamed('/signIn');
    }
  }
}
