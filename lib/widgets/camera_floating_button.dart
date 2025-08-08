import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_theme/app_colors.dart';
import '../modules/electronic_inventory_pictures/electronic_inventory_pictures.dart';

class CameraFloatingButton extends StatelessWidget {
  const CameraFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Get.to( ()=>TextRecognitionScreen());
      },
      backgroundColor: AppColors.primaryColor,
      shape: const CircleBorder(),
      child: const Icon(
        Icons.camera_alt_outlined,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}
