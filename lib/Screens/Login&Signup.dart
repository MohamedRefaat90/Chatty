import 'package:chaty/Controller/MyController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Components/Login/GradientBubble.dart';

import '../Components/Login/LoginBySocial.dart';
import '../Components/Login/LoginCard.dart';
import '../Components/Login/SignupCard.dart';

class Login extends StatelessWidget {
  static String id = 'Login';
  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpend =
        MediaQuery.of(context).viewInsets.bottom > 0 ? true : false;
    bool isLogin = Provider.of<MyController>(context, listen: false).isLogin;

    return Scaffold(
        body: Stack(alignment: Alignment.topLeft, children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromARGB(255, 253, 253, 253),
      ),
      const GradientBubble(top: -100, left: -200),
      const GradientBubble(top: 400, left: 300),
      LoginCard(),
      Visibility(
          visible: isKeyboardOpend == true && isLogin == true ? false : true,
          child: SignUpCard()),
      Visibility(
          visible: isKeyboardOpend == true && isLogin == true ? false : true,
          child: LoginBySocial()),
    ]));
  }
}
