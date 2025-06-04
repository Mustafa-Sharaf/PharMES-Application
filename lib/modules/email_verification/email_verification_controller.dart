import 'package:get/get.dart';

class EmailVerificationController extends GetxController {
  RxString otpCode = ''.obs;

  void updateCode(String code) {
    otpCode.value = code;
  }

  void submitCode(String code) {
    otpCode.value = code;
    print("Code submitted: $code");
  }
}
