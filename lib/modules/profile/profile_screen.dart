import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import 'package:pharmes_app/modules/profile/profile_controller.dart';
import 'package:pharmes_app/modules/profile/update_profile%20_screen.dart';

import '../../language/language_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  ProfileController controller = Get.put<ProfileController>(
    ProfileController(),
  );
  @override
  Widget build(BuildContext context) {
    MyLanguageController myLanguageController = Get.find();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 1.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.1,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.arrow_back_ios, size: 15),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.20),
                  Text('My_Profile'.tr, style: TextStyle(fontSize: 19)),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.3),
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
                        child: const Icon(Icons.edit_outlined, size: 15),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              Obx(() {
                final role = controller.role.value;
                Widget infoUnderImage() {
                  if (role == 1 || role == 2) {
                    return Column(
                      children: [
                        Text(controller.name.value),
                        Text(
                          controller.email.value,
                          style: TextStyle(color: AppColors.Gray),
                        ),
                        Text(
                          controller.phone.value,
                          style: TextStyle(color: AppColors.Gray),
                        ),
                      ],
                    );
                  } else if (role == 3 || role == 4) {
                    return Column(
                      children: [
                        Text(controller.name.value),
                        Text(
                          controller.email.value,
                          style: TextStyle(color: AppColors.Gray),
                        ),
                      ],
                    );
                  }
                  return Container();
                }
                Widget whiteContainer() {
                  if (role == 1) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.local_pharmacy),
                            title: Obx(
                              () => Text(
                                controller.otherInfo.isNotEmpty
                                    ? controller.otherInfo[0].values.first
                                    : '',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.phone),
                            title: Obx(
                              () => Text(
                                controller.otherInfo.length > 1
                                    ? controller.otherInfo[1].values.first
                                    : '',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.location_on),
                            title: Obx(
                              () => Text(
                                controller.otherInfo.length > 2
                                    ? controller.otherInfo[2].values.first
                                    : '',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (role == 2) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.business),
                            title: Obx(
                              () => Text(
                                controller.otherInfo.isNotEmpty
                                    ? controller.otherInfo[0].values.first
                                    : '',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.phone),
                            title: Obx(
                              () => Text(
                                controller.otherInfo.length > 1
                                    ? controller.otherInfo[1].values.first
                                    : '',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.location_on),
                            title: Obx(
                              () => Text(
                                controller.otherInfo.length > 2
                                    ? controller.otherInfo[2].values.first
                                    : '',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (role == 3 || role == 4) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.person),
                            title: Obx(
                              () => Text(
                                controller.name.value,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.email),
                            title: Obx(
                              () => Text(
                                controller.email.value,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(Icons.phone),
                            title: Obx(
                              () => Text(
                                controller.phone.value,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                }

                return Column(
                  children: [
                    infoUnderImage(),
                    const SizedBox(height: 10),
                    whiteContainer(),
                  ],
                );
              }),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.dark_mode),
                        SizedBox(width: MediaQuery.of(context).size.width*0.03),
                        Expanded(child: Text('Dark_Mode'.tr)),
                        Switch(
                          activeTrackColor: AppColors.primaryColor,
                          value: true,
                          onChanged: (_) {},
                        ),
                      ],
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  "Close".tr,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                            title: Text("Language".tr),
                            content: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    myLanguageController.changeLanguage(
                                      "ar",
                                    );
                                  },
                                  child: Text(
                                    "Arabic".tr,
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    myLanguageController.changeLanguage(
                                      "en",
                                    );
                                  },
                                  child: Text(
                                    "English".tr,
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.language),
                          SizedBox(width: MediaQuery.of(context).size.width*0.03),
                          Text('Language'.tr),
                        ],
                      ),
                    ),
                    const Divider(),GestureDetector(
                      onTap: () {
                        Get.to(() =>  UpdateProfileScreen());
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.edit),
                          SizedBox(width: MediaQuery.of(context).size.width*0.03),
                          Expanded(child: Text('Edit_Profile'.tr)),
                        ],
                      ),
                    ),

                    const Divider(),
                    Row(
                      children: [
                        const Icon(Icons.logout, color: Colors.red),
                        SizedBox(width: MediaQuery.of(context).size.width*0.03),
                        Expanded(
                          child: Text(
                            'Log_Out'.tr,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
