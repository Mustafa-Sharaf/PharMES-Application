import 'package:flutter/material.dart';
import '../../app_theme/app_colors.dart';

class CustomerDebts extends StatelessWidget {
  const CustomerDebts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        title: Text(
          "Customer Debts",
          style: TextStyle(color: AppColors.white, fontSize: 25),
        ),
      ),
      body: Center(

      ),
    );
  }
}
