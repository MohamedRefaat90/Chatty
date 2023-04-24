import 'package:chaty/Constants.dart';
import 'package:chaty/Controller/MyController.dart';
import 'package:chaty/Services/Auth.dart';
import 'package:chaty/utilits/snakbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Screens/Chat.dart';
import '../ArrowButton.dart';
import '../Logo.dart';
import 'GradientButton.dart';
import 'TextBtn.dart';
import 'customPainter.dart';
import 'customTextField.dart';

class LoginCard extends StatefulWidget {
  LoginCard({
    super.key,
  });

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController EmailCont = TextEditingController();
  TextEditingController PassCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isSignup = Provider.of<MyController>(context).isSignup;
    double moveLoginCard = Provider.of<MyController>(context).moveLoginCard;
    int duration = Provider.of<MyController>(context).duration;
    String Email = '';
    String Password = '';
    MyController provider = Provider.of<MyController>(context);
    double space = 140;

    return AnimatedPositioned(
      duration: Duration(milliseconds: duration),
      top: moveLoginCard,
      left: 20,
      child: CustomPaint(
        painter: BoxShadowPainter1(),
        child: ClipPath(
          clipper: CustomClip(),
          child: Container(
            width: 350,
            height: 620,
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Center(child: Logo()),
                  // const SizedBox(height: 30),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customTextField(
                          lable: 'Email',
                          isPass: false,
                          icon: Icon(Icons.email),
                          onSaved: (value) => Email = value!.trim(),
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field is Required';
                            } else if (!provider.isValidEmail(value)) {
                              return 'Enter Valid Email';
                            }
                            return null;
                          },
                        ),
                        // const SizedBox(height: 10),
                        customTextField(
                          lable: 'Password',
                          isPass: true,
                          // cont: PassCont,
                          icon: Icon(Icons.key),
                          onSaved: (value) => Password = value!.trim(),
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field is Required';
                            }
                            return null;
                          },
                        ),
                        const TextBtn(),
                        const SizedBox(height: 30),
                        GradientButton(
                            width: 200,
                            height: 55,
                            lable: 'Login',
                            alignment: MainAxisAlignment.end,
                            fontsize: 30,
                            icon: const SizedBox(),
                            press: () async {
                              if (formKey.currentState!.validate()) {
                                try {
                                  formKey.currentState!.save();
                                  // print('$Email');
                                  // print('$Password');

                                  bool isVerified = await Auth()
                                      .Login(Email, Password, context);
                                  if (isVerified) {
                                    Navigator.pushReplacementNamed(
                                        context, ChatPage.id,
                                        arguments: Email);
                                  } else {
                                    showSnakBar(context,
                                        'Check Email For Vericication Link');
                                  }
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    provider.Snakbar(context,
                                        'No user found for that email.');
                                  } else if (e.code == 'wrong-password') {
                                    provider.Snakbar(context,
                                        'Wrong password provided for that user.');
                                  }
                                }
                              } else {
                                // space = 100;
                                provider.Snakbar(
                                    context, 'Fields Must not be Empty');
                              }
                            }),
                        SizedBox(height: 120),
                        
                        ArrowButton(
                          isSignup: isSignup,
                          color: kPrimaryColor,
                          alignment: MainAxisAlignment.end,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
