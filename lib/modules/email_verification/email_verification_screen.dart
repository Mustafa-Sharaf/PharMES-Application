import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../helpers/clipper_forgetpass.dart';
import 'email_verification_controller.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmailVerificationController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: Clipper(),
                child: Container(
                  height: 210,
                  color: AppColors.primaryColor,
                  child: Align(
                    alignment: const Alignment(-0.3, -0.3),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                        const SizedBox(width: 30),
                         Text('Email_Verification'.tr,
                            style: TextStyle(fontSize: 25, color: Colors.white)),
                        const SizedBox(width: 30),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
               Text(
                'Get_Your_Code'.tr,
                style: TextStyle(color: AppColors.primaryColor,
                    fontSize: 22, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),
               Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  'Please_Enter_the_6_digit_code_that_sent_to_your_email_address'.tr,
                  style: TextStyle(fontSize: 17, color: AppColors.Gray, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 25),
              OtpTextField(
                numberOfFields: 6,
                borderColor: AppColors.primaryColor,
                showFieldAsBox: true,
                onCodeChanged: controller.updateCode,
                onSubmit: controller.submitCode,
              ),
              const SizedBox(height: 55),
              MaterialButton(
                onPressed: () {Get.toNamed('/resetPass');},
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: AppColors.primaryColor,
                child:Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Text(
                    'Verify_and_Proceed'.tr,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

