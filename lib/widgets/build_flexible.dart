import 'package:flutter/material.dart';
import '../app_theme/app_colors.dart';

class BuildFlexible extends StatelessWidget {
  const BuildFlexible({super.key, required this.title, required this.text});
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: text,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 14,
                color: AppColors.DarkGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
