import 'package:flutter/material.dart';


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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage:AssetImage(image),
          ),
          SizedBox(height:MediaQuery.of(context).size.height*0.01),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
