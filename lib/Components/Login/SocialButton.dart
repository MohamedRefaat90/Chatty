import 'dart:math';

import 'package:chaty/Constants.dart';
import 'package:chaty/Controller/MyController.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.icon,
    required this.press,
    required this.circleColor,
    required this.iconColor,
  });
  final Color circleColor;
  final Color iconColor;
  final IconData icon;
 final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    bool isSignup = Provider.of<MyController>(context).isSignup;

    return Transform.rotate(
      angle: pi - 10,
      child: GestureDetector(
        onTap: press,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: circleColor),
          child: Center(
              child: FaIcon(
                        icon,
                        color: isSignup ? iconColor : kWhite,
                      )),
        ),
      ),
    );
  }
}



