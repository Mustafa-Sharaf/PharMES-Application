import 'package:flutter/material.dart';
import 'package:pharmes_app/app_theme/app_colors.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        title: Text("My Profile",
          style: TextStyle(
              color:Colors.white,
              fontSize: 30
            ),
           ),
      ),
      body: Center(
        child:Column(
          children: [


          ],
        ),
      ),
    );
  }
}


