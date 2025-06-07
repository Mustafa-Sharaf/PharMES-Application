import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_theme/app_colors.dart';
import '../../helpers/clipper_forgetpass.dart';
import 'forget_password_controller.dart';
class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgetPasswordController controller = Get.put(ForgetPasswordController());
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
                        Text('Forget Password',
                            style: TextStyle(fontSize: 25, color: Colors.white)),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 35,),
              Text('Mail Address Here',
                style: TextStyle(color: AppColors.primaryColor,
                    fontSize: 22,fontWeight: FontWeight.w500),),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text('Enter the email address associated with your account ',
                  style: TextStyle(fontSize: 17, color: AppColors.Gray,fontWeight: FontWeight.w600),),
              ),
              SizedBox(height: 25,),
              GetBuilder<ForgetPasswordController>(
                init: ForgetPasswordController(),
                builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter your Email',
                      prefixIcon: Icon(Icons.email, color: AppColors.Gray),
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
                  ),

                );}
                ),
              SizedBox(height: 55,),
              MaterialButton(onPressed: (){Get.toNamed('/emailverify');},shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),color: AppColors.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
                  child: Text('Verify and Proceed',style: TextStyle(color: AppColors.white,
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

