import 'package:flutter/material.dart';
import 'package:tasks/task/shared/style/colors_manager.dart';

class HomeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height - 220);

    path.lineTo(size.width / 3, size.height - 220);

    path.quadraticBezierTo(size.width - 150, size.height - 220,
        size.width - 135, size.height - 150);

    path.quadraticBezierTo(size.width - 110, size.height - 10,
        size.width, size.height - 30);

    path.lineTo(size.width, size.width - 90);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
