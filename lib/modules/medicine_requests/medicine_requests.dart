import 'package:flutter/material.dart';

import '../../app_theme/app_colors.dart';

class MedicineRequests extends StatelessWidget {
  const MedicineRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        title: Text(
          "Medicine Requests",
          style: TextStyle(color: AppColors.white, fontSize: 25),
        ),
      ),

    );
  }
}
