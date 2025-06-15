import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/modules/profile/profile_controller.dart';
import 'package:pharmes_app/modules/profile/update_profile_controller.dart';

import '../../app_theme/app_colors.dart';
import '../../widgets/app_decoration.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({super.key});

  final UpdateProfileController controller = Get.put(UpdateProfileController());
  final ProfileController controllerP = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: height * 0.05,
                      width: width * 0.1,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.arrow_back_ios, size: 15),
                    ),
                  ),
                  SizedBox(width: width * 0.18),
                  const Text('Update Profile', style: TextStyle(fontSize: 19)),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 125,
                      height: 125,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.green,
                            Colors.orange,
                            Colors.purple,
                            Colors.red,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/logodrawer.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.primaryColor,
                        ),
                        child: const Icon(Icons.camera_alt_outlined, size: 15),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Text Fields
              Column(
                children: [
                  TextField(
                    controller: controller.nameController,
                    decoration: AppDecorations.customInputDecoration('Name', width, height),
                    cursorColor: AppColors.primaryColor,

                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: controller.emailController,
                    decoration: AppDecorations.customInputDecoration('Email', width, height),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: controller.phoneController,
                    decoration: AppDecorations.customInputDecoration('Phone', width, height),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: controller.password,
                    decoration: AppDecorations.customInputDecoration('password', width, height),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: controller.confirmPassword,
                    decoration: AppDecorations.customInputDecoration('confirmPassword', width, height),
                  ),
                  const SizedBox(height: 15),
                  if (controllerP.otherInfo.isNotEmpty) ...[
                    TextField(
                      controller: controller.info1Controller,
                      decoration: AppDecorations.customInputDecoration(controllerP.otherInfo[0].keys.first,width,height),
                    ),
                    const SizedBox(height: 15),
                    if (controllerP.otherInfo.length > 1)
                      TextField(
                        controller: controller.info2Controller,
                        decoration: AppDecorations.customInputDecoration(controllerP.otherInfo[1].keys.first,width,height),
                      ),
                    if (controllerP.otherInfo.length > 2) ...[
                      const SizedBox(height: 15),
                      TextField(
                        controller: controller.info3Controller,
                        decoration: AppDecorations.customInputDecoration(controllerP.otherInfo[2].keys.first,width,height),
                      ),
                    ],
                  ]
                ],
              ),
              const SizedBox(height: 30),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: height * 0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    controller.updateProfile();
                  },
                  child: const Text(
                    'Save Profile',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
