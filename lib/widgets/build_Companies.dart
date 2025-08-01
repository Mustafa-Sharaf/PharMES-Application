import 'package:flutter/material.dart';

import '../configurations/http_helpers.dart';
class BuildCompanies extends StatelessWidget {
  final String? image;
  final String title;

  const BuildCompanies({Key? key, this.image, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? fullImageUrl;
    if (image != null && image!.isNotEmpty) {
      fullImageUrl = '$imgURL$image';
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: (fullImageUrl != null)
                ? NetworkImage(fullImageUrl)
                : const AssetImage('assets/images/logo.jpg') as ImageProvider,
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          )

        ],
      ),
    );
  }
}


/*
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
          Text(title, style: const TextStyle(fontSize: 10)),
        ],
      ),
    );
  }
}
*/
