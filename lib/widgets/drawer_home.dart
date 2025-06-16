import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Theme/theme_controller.dart';
import '../app_theme/app_colors.dart';

class DrawerHome extends StatelessWidget {
  DrawerHome({super.key});
  final ThemeController themeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Drawer(
        backgroundColor: themeController.isDarkMode.value?AppColors.dark:AppColors.white,
        child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height:MediaQuery.of(context).size.height*0.30,
                child: DrawerHeader(
                  decoration: const BoxDecoration(color:AppColors.primaryColor,),
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.start ,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('PharMes'.tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:AssetImage('assets/images/logodrawer.jpg'),
                      ),
                      SizedBox(height:MediaQuery.of(context).size.height*0.01),
                      const Text('Mustafa Sharaf',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                      ),
                      const Text('MustafaSharaf@gmail.com',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ListTile(
                leading: Icon(Icons.person),
                title: Text('My_Profile'.tr),
                onTap: () {
                  Get.toNamed('/profileScreen');
                },
              ),
              ListTile(
                leading: Icon(Icons.inventory_2),
                title: Text('My_Pharmacy_Management'.tr),
                onTap: () {
                  Get.toNamed('/pharmacyManagementScreen');
                },
              ),
              ListTile(
                leading: Icon(Icons.support),
                title: Text('Support'.tr),
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share_Application'.tr),
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip),
                title: Text('Privacy_Policy'.tr),
              ),

            ]
        ),
      );
    }

    );
  }
}
