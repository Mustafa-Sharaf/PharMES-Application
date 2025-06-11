import 'package:flutter/material.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          foregroundColor:AppColors.white  ,
          title:Text("Notifications",
            style: TextStyle(
                color: AppColors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold
            ),
          )
      ),
    );
  }
}
