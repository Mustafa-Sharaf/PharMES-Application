

import 'package:flutter/material.dart';

import '../../app_theme/app_colors.dart';

class ForeignMedicineInventoryManagement extends StatelessWidget {
  const ForeignMedicineInventoryManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        title: Text(
          "Medicine Inventory Management",
          style: TextStyle(color: AppColors.white, fontSize: 18),
        ),
      ),
      body: Center(

      ),
    );
  }
}

