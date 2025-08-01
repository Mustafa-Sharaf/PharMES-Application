import 'package:flutter/material.dart';

import '../../app_theme/app_colors.dart';

class ElectronicInventoryPictures extends StatelessWidget {
  const ElectronicInventoryPictures({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        title: Text(
          "Electronic Inventory Pictures",
          style: TextStyle(color: AppColors.white, fontSize: 20),
        ),
      ),
      body: Center(

      ),
    );
  }
}
