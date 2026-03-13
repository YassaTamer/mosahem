import 'package:flutter/material.dart';

class ProfileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width - 40, 0);

    path.lineTo(size.width, size.height / 2);

    path.lineTo(size.width - 40, size.height);

    path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
