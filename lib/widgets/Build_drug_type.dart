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
      width: MediaQuery.of(context).size.width*0.24,
      margin:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
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
              height: MediaQuery.of(context).size.width*0.18,
              width: MediaQuery.of(context).size.width*0.18,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.01,),
            child: Text(titleType, style: const TextStyle(fontSize: 13)),
          ),
        ],
      ),
    );
  }
}
