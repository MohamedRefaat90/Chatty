import 'package:flutter/material.dart';

class CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    double w = size.width;
    double h = size.height;

    // (0,0)   Defult =>       // 1
    path.lineTo(0, h - 200); // 2
    path.lineTo(w, h + 20); // 3
    path.lineTo(w, 0); // 4
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BoxShadowPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    // here are my custom shapes
    double w = size.width;
    double h = size.height;

    // (0,0)   Defult =>       // 1
    path.lineTo(20, h - 180); // 2
    path.lineTo(w - 20, h + 10); // 3
    path.lineTo(w, 0); // 4
    path.close();

    canvas.drawShadow(path, Color.fromARGB(255, 0, 0, 0), 20.0, false);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class BoxShadowPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    // here are my custom shapes
    double w = size.width;
    double h = size.height;

    // (0,0)   Defult =>       // 1
    path.lineTo(40, h - 120); // 2
    path.lineTo(w - 20, h + 10); // 3
    path.lineTo(w, 0); // 4
    path.close();
    
    canvas.drawShadow(path, Color.fromARGB(255, 0, 0, 0), 60.0, false);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
