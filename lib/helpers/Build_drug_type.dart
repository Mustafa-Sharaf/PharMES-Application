import 'package:flutter/material.dart';


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
    return Container(
      width: MediaQuery.of(context).size.width*0.2,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:5),
            child: Text(titleType, style: const TextStyle(fontSize: 13)),
          ),
        ],
      ),
    );
  }
}
