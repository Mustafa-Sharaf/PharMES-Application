import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Theme/theme_controller.dart';
import '../app_theme/app_colors.dart';


class BuildCompanies extends StatelessWidget {
  final String image;
  final String title;
  const BuildCompanies({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.02,
        right: MediaQuery.of(context).size.width * 0.02
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.084,
            backgroundImage:AssetImage(image),
          ),
          SizedBox(height:MediaQuery.of(context).size.height*0.01),
          Text(title, style: TextStyle(fontSize: 10,color: themeController.isDarkMode.value?AppColors.white:AppColors.black,)),
        ],
      ),
    );
  }
}
