import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/modules/reset_password/reset_password_controller.dart';

import '../../app_theme/app_colors.dart';
import '../../helpers/clipper_forgetpass.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ResetPasswordController controller = Get.put(ResetPasswordController());
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
                    child: Row(mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_back_ios,color: AppColors.white,size: 20,),
                        SizedBox(width: 30,),
                        Text('Reset_Password'.tr,
                            style: TextStyle(fontSize: 25, color: Colors.white)),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 35,),
              Text('Enter_New_Password'.tr,
                style: TextStyle(color: AppColors.primaryColor,
                    fontSize: 22,fontWeight: FontWeight.w500),),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text('Enter_new_password_must_be_different_from_previously_used_password'.tr,
                  style: TextStyle(fontSize: 17, color: AppColors.Gray,fontWeight: FontWeight.w600),),
              ),
              SizedBox(height: 25,),
              GetBuilder<ResetPasswordController>(
                builder: (controller) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Obx(() => TextFormField(
                          controller: controller.passwordController,
                          obscureText: controller.obscurePassword.value,
                          decoration: InputDecoration(
                            hintText: 'Password'.tr,
                            prefixIcon: Icon(Icons.lock_outline, color: AppColors.Gray),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.obscurePassword.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.Gray,
                              ),
                              onPressed: controller.togglePasswordVisibility,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.Gray),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          cursorColor: AppColors.primaryColor,
                        )),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Obx(() => TextFormField(
                          controller: controller.confirmPassController,
                          obscureText: controller.obscureConfirmPassword.value,
                          decoration: InputDecoration(
                            hintText: 'Confirm_Password'.tr,
                            prefixIcon: Icon(Icons.lock_outline, color: AppColors.Gray),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.obscureConfirmPassword.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.Gray,
                              ),
                              onPressed: controller.toggleConfirmPasswordVisibility,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.Gray),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          cursorColor: AppColors.primaryColor,
                        )),
                      ),
                    ],
                  );
                },
              ),

              SizedBox(height: 55,),
              MaterialButton(onPressed: (){Get.offAllNamed('/signIn');},shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),color: AppColors.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 70),
                  child: Text('Continue'.tr,style: TextStyle(color: AppColors.white,
                      fontSize: 20),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

