import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildPharmacyManagement extends StatelessWidget {
  const BuildPharmacyManagement({
    super.key,
    required this.text,
    required this.icon,
    required this.pathName,
  });
  final String text;
  final IconData icon;
  final String pathName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(pathName),
      child: Padding(
        padding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.03,
          left: MediaQuery.of(context).size.width * 0.03,
          top: MediaQuery.of(context).size.width * 0.02,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Icon(icon, size: 25, color: Color(0xFF2C5FE0)),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Text(
                text,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
