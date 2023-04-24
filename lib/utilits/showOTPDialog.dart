import 'package:chaty/Constants.dart';
import 'package:flutter/material.dart';

showOTPDialog(
    {required BuildContext context,
    required TextEditingController Code,
    required VoidCallback press}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            title: const Text(
              'Enter OTP',
              textAlign: TextAlign.center,
            ),
            content: TextFormField(
              controller: Code,
              decoration: const InputDecoration(hintText: 'Enter OTP'),
            ),
            actions: [
              MaterialButton(
                  onPressed: press, color: kPrimaryColor, child: Text('Submit'))
            ],
          ));
}
