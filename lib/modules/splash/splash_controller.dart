import 'package:get/get.dart';
import 'dart:async';

class SplashController extends GetxController {
  final imageSize = 25.0.obs;
  final showText = true.obs;
  late Timer _blinkTimer;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 100), () {
      imageSize.value = 160.0;
    });
    _blinkTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      showText.value = !showText.value;
    });

    Future.delayed(const Duration(seconds: 4), () {
      _blinkTimer.cancel();
      Get.offNamed('/Onboarding');
    });
  }

  @override
  void onClose() {
    _blinkTimer.cancel();
    super.onClose();
  }
}
