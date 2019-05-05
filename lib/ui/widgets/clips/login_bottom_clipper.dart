import 'package:flutter/material.dart';

class LoginBottomClipper extends CustomClipper<Path>{
 
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 65);
   // path.lineTo(size.width, 0.0);
   path.quadraticBezierTo(size.width * 0.25, size.height, size.width * 0.59, size.height - 90);
   path.quadraticBezierTo(size.width * 0.75, size.height - 135, size.width, size.height - 60);
   path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}