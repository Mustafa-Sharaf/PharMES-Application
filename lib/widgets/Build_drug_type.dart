import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_theme/app_colors.dart';
import '../app_theme/theme_controller.dart';
import '../configurations/http_helpers.dart';

class BuildDrugType extends StatelessWidget {
  final String image;
  final String titleType;
  const BuildDrugType({
    super.key,
    required this.image,
    required this.titleType,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    String? fullImageUrl;
    if (image.isNotEmpty) {
      fullImageUrl = '$imgURL$image';
    }
    return Container(
      width: MediaQuery.of(context).size.width * 0.24,
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.02,
      ),
      decoration: BoxDecoration(
        color: themeController.isDarkMode.value?AppColors.componentDark :Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: fullImageUrl != null
                ? Image.network(
                    fullImageUrl,
                    height: MediaQuery.of(context).size.width * 0.18,
                    width: MediaQuery.of(context).size.width * 0.18,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/logo.jpg',
                    height: MediaQuery.of(context).size.width * 0.18,
                    width: MediaQuery.of(context).size.width * 0.18,
                    fit: BoxFit.cover,
                  ),
          ),

          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.01,
            ),
            child: Center(
              child: Text(
                titleType,
                style: const TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            )
          ),
        ],
      ),
    );
  }
}
