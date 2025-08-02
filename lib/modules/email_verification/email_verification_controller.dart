import 'dart:convert';
import 'package:get/get.dart';

import '../../configurations/http_helpers.dart';

class EmailVerificationController extends GetxController {
  RxString otpCode = ''.obs;
  RxBool isLoading = false.obs;
  late String email;

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments['email'];
  }

  void updateCode(String code) {
    otpCode.value = code;
  }

  void submitCode(String code) {
    otpCode.value = code;
    print("Code submitted: $code");
  }

  Future<void> verifyCodeAndProceed() async {
    if (otpCode.value.length != 6) {
      Get.snackbar("error", "Please enter a 6-digit code");
      return;
    }
    isLoading.value = true;

    try {
      final response = await HttpHelper.postData(
        url: 'passwordAndEmail/verifyCode',
        body: {
          'email': email,
          'code': otpCode.value},
      );

      if (response.statusCode == 200) {
        Get.toNamed('/reset', arguments: {'email': email});
      } else {
        final data = jsonDecode(response.body);
        print(response.body);
        Get.snackbar("error", data['error'] ?? "invalide code");
      }
    } catch (e) {
      Get.snackbar("error", ": $e");
    } finally {
      isLoading.value = false;
    }
  }
}
