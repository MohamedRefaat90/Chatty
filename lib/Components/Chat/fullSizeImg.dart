import 'package:flutter/material.dart';

import '../../Model/Message.dart';

class fullSizeImg extends StatelessWidget {
  const fullSizeImg({super.key, required this.message});

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: message.text,
      child: Container(
          child: Image.network(
        message.text,
      )),
    );
  }
}