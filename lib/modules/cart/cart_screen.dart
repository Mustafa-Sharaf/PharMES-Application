import 'package:flutter/material.dart';

import '../../app_theme/app_colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          "Cart",
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
      body: Center(child: Text("Cart screen")),
    );
  }
}
