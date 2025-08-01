
import 'package:flutter/material.dart';

import '../../app_theme/app_colors.dart';


class InventoryByName extends StatelessWidget {
  const InventoryByName({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        title: Text(
          "Inventory By Name",
          style: TextStyle(color: AppColors.white, fontSize: 25),
        ),
      ),
      body: Center(

      ),
    );
  }
}
