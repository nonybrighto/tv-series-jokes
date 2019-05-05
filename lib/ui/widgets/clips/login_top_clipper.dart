
import 'package:flutter/material.dart';

class LoginTopClipper extends CustomClipper<Path>{
 
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 40);
   // path.lineTo(size.width, 0.0);
   path.quadraticBezierTo(size.width * 0.30, size.height, size.width * 0.5, size.height - 70);
   path.quadraticBezierTo(size.width * 0.75, size.height - 135, size.width, size.height - 10);
   path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}