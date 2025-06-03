// lib/modules/onboarding/onboarding_controller.dart
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/2.png',
      'text': ' Get timely alerts before any medication expires never lose money again ',
    },
    {
      'image': 'assets/images/1.png',
      'text': 'Manage your pharmacy inventory effortlessly track stock levels ,update quantities',
    },
    {
      'image': 'assets/images/Web search-rafiki.png',
      'text': 'Quickly find any medicine you need with our smart search no more walking around the pharmacy',
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
