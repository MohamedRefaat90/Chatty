import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants.dart';
import '../Controller/MyController.dart';

class ArrowButton extends StatelessWidget {
  const ArrowButton({
    super.key,
    required this.isSignup,
    required this.alignment,
    required this.color,
  });

  final bool isSignup;
  final MainAxisAlignment alignment;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: color,
          child: GestureDetector(
            onTap: () {
              Provider.of<MyController>(context, listen: false).animateCards(context);
              Provider.of<MyController>(context, listen: false).isLogin = !Provider.of<MyController>(context, listen: false).isLogin ;
            },
            child: Icon(isSignup ? Icons.arrow_downward : Icons.arrow_upward,
                color: kWhite, size: 18),
          ),
        ),
      ],
    );
  }
}