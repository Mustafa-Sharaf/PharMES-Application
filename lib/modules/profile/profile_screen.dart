import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
import 'package:pharmes_app/modules/logout/logout_controller.dart';
import 'package:pharmes_app/modules/profile/profile_controller.dart';
import 'package:pharmes_app/modules/profile/update_profile%20_screen.dart';
import '../../app_theme/theme_controller.dart';
import '../../language/language_controller.dart';
import 'delete_profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final ProfileController controller= Get.find();
  LogOutController controllerLogout = Get.put<LogOutController>(
    LogOutController(),
  );
  DeleteProfileController deletecontroller = Get.put<DeleteProfileController>(
    DeleteProfileController(),
  );
  final ThemeController themeController = Get.find();
  @override
  Widget build(BuildContext context) {
    MyLanguageController myLanguageController = Get.find();
    return Obx(
      //const Color(0xFF2A282D)
        (){return
          Scaffold(
            backgroundColor:themeController.isDarkMode.value?AppColors.backgroundDark : AppColors.background,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01,),
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.1,
                              decoration: BoxDecoration(
                                color:  themeController.isDarkMode.value?AppColors.componentDark:AppColors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(Icons.arrow_back_ios, size: 15,
                                color: themeController.isDarkMode.value?AppColors.white : AppColors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.24),
                        const Text('My Profile', style: TextStyle(fontSize: 19)),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.24),
                        Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.0001,),
                          child: GestureDetector(
                            onTap: () {
                              Get.bottomSheet(
                                Container(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01,),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                                  ),
                                  child: ListTile(
                                    leading: const Icon(Icons.delete, color: Colors.red),
                                    title: const Text('Delete Profile',style: TextStyle(color: AppColors.black),),
                                    onTap: () {
                                      deletecontroller.deleteProfile(controller.role.value);
                                    },
                                  ),
                                ),
                              );
                            },

                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.1,
                              decoration: BoxDecoration(
                                color:  themeController.isDarkMode.value?AppColors.componentDark:AppColors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(Icons.more_horiz, size: 15,color:themeController.isDarkMode.value?AppColors.white : AppColors.black,),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.width * 0.36,
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
                              padding:  EdgeInsets.all(MediaQuery.of(context).size.width * 0.005,),
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

                    SizedBox(height: MediaQuery.of(context).size.width * 0.03,),
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
                              color: themeController.isDarkMode.value?AppColors.backgroundDark : AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Icon(Icons.local_pharmacy ,color: themeController.isDarkMode.value?AppColors.white : AppColors.backgroundDark,),
                                  title: Obx(
                                        () => Text(
                                      controller.otherInfo.isNotEmpty
                                          ? controller.otherInfo[0].values.first
                                          : '',
                                      style: TextStyle(fontSize: 15,color: themeController.isDarkMode.value?AppColors.white : AppColors.backgroundDark,),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Icon(Icons.phone,color: themeController.isDarkMode.value?AppColors.white : AppColors.backgroundDark,),
                                  title: Obx(
                                        () => Text(
                                      controller.otherInfo.length > 1
                                          ? controller.otherInfo[1].values.first
                                          : '',
                                      style: TextStyle(fontSize: 15,color:themeController.isDarkMode.value?AppColors.white : AppColors.backgroundDark,),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Icon(Icons.location_on,color: themeController.isDarkMode.value?AppColors.white : AppColors.backgroundDark,),
                                  title: Obx(
                                        () => Text(
                                      controller.otherInfo.length > 2
                                          ? controller.otherInfo[2].values.first
                                          : '',
                                      style: TextStyle(fontSize: 15,color:themeController.isDarkMode.value?AppColors.white : AppColors.backgroundDark,),
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
                              color:  themeController.isDarkMode.value?AppColors.componentDark:AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Icon(Icons.business,color: themeController.isDarkMode.value?AppColors.white : AppColors.backgroundDark,),
                                  title: Obx(
                                        () => Text(
                                      controller.otherInfo.isNotEmpty
                                          ? controller.otherInfo[0].values.first
                                          : '',
                                      style: TextStyle(fontSize: 15,color: themeController.isDarkMode.value?AppColors.white : AppColors.backgroundDark,),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Icon(Icons.phone,color: themeController.isDarkMode.value?AppColors.white : AppColors.backgroundDark,),
                                  title: Obx(
                                        () => Text(
                                      controller.otherInfo.length > 1
                                          ? controller.otherInfo[1].values.first
                                          : '',
                                      style: TextStyle(fontSize: 15,color: themeController.isDarkMode.value?AppColors.white : AppColors.backgroundDark,),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Icon(Icons.location_on,color: themeController.isDarkMode.value?AppColors.white : AppColors.backgroundDark,),
                                  title: Obx(
                                        () => Text(
                                      controller.otherInfo.length > 2
                                          ? controller.otherInfo[2].values.first
                                          : '',
                                      style: TextStyle(fontSize: 15,color: themeController.isDarkMode.value?AppColors.white : AppColors.backgroundDark,),
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
                              color: themeController.isDarkMode.value?AppColors.white : AppColors.backgroundDark,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Icon(Icons.person,color: themeController.isDarkMode.value?AppColors.white : AppColors.backgroundDark,),
                                  title: Obx(
                                        () => Text(
                                      controller.name.value,
                                      style: TextStyle(fontSize: 15,color: themeController.isDarkMode.value?AppColors.white : AppColors.backgroundDark,),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Icon(Icons.email,color: themeController.isDarkMode.value?AppColors.white : AppColors.backgroundDark,),
                                  title: Obx(
                                        () => Text(
                                      controller.email.value,
                                      style: TextStyle(fontSize: 15,color: themeController.isDarkMode.value?AppColors.white : AppColors.backgroundDark,),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Icon(Icons.phone,color:themeController.isDarkMode.value?AppColors.white : AppColors.backgroundDark,),
                                  title: Obx(
                                        () => Text(
                                      controller.phone.value,
                                      style: TextStyle(fontSize: 15,color: themeController.isDarkMode.value?AppColors.white : AppColors.backgroundDark,),
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
                        color: themeController.isDarkMode.value?AppColors.componentDark : AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.dark_mode,color: themeController.isDarkMode.value?AppColors.white : AppColors.black,),
                              const SizedBox(width: 10),
                              Expanded(child: Text('Dark_Mode'.tr,style: TextStyle(color: themeController.isDarkMode.value?AppColors.white : AppColors.black,),)),
                              Obx(() => Switch(
                                activeTrackColor: AppColors.primaryColor,
                                activeColor: Colors.white,
                                value: themeController.isDarkMode.value,
                                onChanged: (_) {
                                  themeController.toggleTheme();
                                },
                              )),

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
                                Icon(Icons.language,color: themeController.isDarkMode.value?AppColors.white : AppColors.black,),
                                SizedBox(width: MediaQuery.of(context).size.width*0.03),
                                Text('Language'.tr,style: TextStyle(color: themeController.isDarkMode.value?AppColors.white : AppColors.black,),),
                              ],
                            ),
                          ),
                          const Divider(),GestureDetector(
                            onTap: () {
                              Get.to(() =>  UpdateProfileScreen());
                            },
                            child: Row(
                              children: [
                                Icon(Icons.edit,color: themeController.isDarkMode.value?AppColors.white : AppColors.black,),
                                const SizedBox(width: 10),
                                Expanded(child: Text('Edit_Profile'.tr,style:TextStyle(color: themeController.isDarkMode.value?AppColors.white : AppColors.black,))),
                              ],
                            ),
                          ),

                          const Divider(),
                          Row(
                            children: [
                              const Icon(Icons.logout, color: Colors.red),
                              const SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: (){
                                    controllerLogout.logout(controller.role.value);
                                  },
                                  child: Text(
                                    'Log_Out'.tr,
                                    style: TextStyle(color: Colors.red),
                                  ),
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
    );
  }
}



