import 'package:flutter/material.dart';

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(size.width - 295, size.height - 80, size.width - 200, size.height - 80);
    path.quadraticBezierTo(size.width -75, size.height - 75,size.width - 65, size.height - 83);
    path.quadraticBezierTo(size.width -35, size.height - 95,size.width - 20, size.height - 120);
    path.quadraticBezierTo(size.width -10, size.height - 130,size.width , 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
