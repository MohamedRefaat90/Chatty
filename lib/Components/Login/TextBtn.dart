import 'package:flutter/material.dart';

class TextBtn extends StatelessWidget {
  const TextBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: const Text(
          'Forget Password ?',
          style: TextStyle(color: Color.fromARGB(255, 170, 170, 170)),
        ),
        onPressed: () {});
  }
}

