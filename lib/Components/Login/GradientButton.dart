import 'package:flutter/material.dart';

import '../../Constants.dart';

class GradientButton extends StatelessWidget {
  GradientButton(
      {super.key,
      required this.width,
      required this.height,
      required this.lable,
      required this.alignment,
      required this.fontsize,
      this.icon,
      required this.press});

  final double width;
  final double height;
  final double fontsize;
  final String lable;
  final MainAxisAlignment alignment;
  final VoidCallback press;
  Widget? icon;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        GestureDetector(
          onTap: press,
          child: Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color,
                gradient: LinearGradient(
                    tileMode: TileMode.clamp,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [kPrimaryColor, kSecondryColor]),
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon!,
                Text(
                  lable,
                  style: TextStyle(color: Colors.white, fontSize: fontsize),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
