import 'package:chaty/Constants.dart';
import 'package:flutter/material.dart';

class GradientBubble extends StatelessWidget {
  const GradientBubble({
    super.key,
    required this.top,
    required this.left,
  });
  final double top;
  final double left;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [kPrimaryColor, kSecondryColor]),
        ),
      ),
    );
  }
}
