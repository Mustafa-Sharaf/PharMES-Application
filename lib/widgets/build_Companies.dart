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
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      child: Column(
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.084,
            backgroundImage:AssetImage(image),
          ),
          SizedBox(height:MediaQuery.of(context).size.height*0.01),
          Text(title, style: const TextStyle(fontSize: 10)),
        ],
      ),
    );
  }
}
