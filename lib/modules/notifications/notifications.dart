import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          foregroundColor:AppColors.white  ,
          title:Text("Notifications".tr,
            style: TextStyle(
                color: AppColors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold
            ),
          )
      ),
     /* body: ElevatedButton(
          onPressed:(){
            Get.snackbar(
              'Error'.tr,
              'Failed_to_fetch_medications'.tr,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }, child:Center(
        child: Text("snackbar"),
      )),*/
    );
  }
}
