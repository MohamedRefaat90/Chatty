import 'package:flutter/material.dart';

import '../Constants.dart';

class MyController extends ChangeNotifier {
  // Initial Values
  double moveSignupCard = -520;
  double moveLoginCard = 50;
  double moveSocialButtons = 60; // 70
  bool isSignup = false;
  int duration = 300;
  bool isLogin = true;

  animateCards(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    moveSignupCard = !isSignup ? 50 : -520;
    moveLoginCard = !isSignup ? -500 : 50;
    moveSocialButtons = !isSignup ? size.height * 0.74 : size.height * 0.05;
    isSignup = !isSignup;
    notifyListeners();
  }

  bool isValidPassword(String pass) {
    String passWithoutSpaces = pass.trim();
    bool passvalid = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])')
        .hasMatch(passWithoutSpaces);

    return passvalid;
  }

  bool isValidEmail(String email) {
    String emailWithoutSpaces = email.trim();
    bool valid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailWithoutSpaces);
    return valid;
  }

  void Snakbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      padding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [kPrimaryColor, kSecondryColor])),
        child: Row(
          children: [
            Text(
              message,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ));
  }

  bool validatePhoneNumber(String phoneNumber) {
    RegExp regExp = new RegExp(r'^\d\d\d\d\d\d\d\d\d\d\d$');
    return regExp.hasMatch(phoneNumber);
  }
}
