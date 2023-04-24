import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Constants.dart';
import '../../Controller/MyController.dart';
import '../../Services/Auth.dart';
import '../ArrowButton.dart';
import '../Logo.dart';
import 'GradientButton.dart';
import 'customPainter.dart';
import 'customTextField.dart';

class SignUpCard extends StatefulWidget {
  SignUpCard({super.key});
  static bool isLogin = false;

  @override
  State<SignUpCard> createState() => _SignUpCardState();
}

class _SignUpCardState extends State<SignUpCard> {
// static  GlobalKey<FormState> formKey2 = GlobalKey();
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController NameCon = TextEditingController();
  TextEditingController EmaCon = TextEditingController();
  TextEditingController PassCon = TextEditingController();
  TextEditingController ConfPassCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double moveSignupCard = Provider.of<MyController>(context).moveSignupCard;
    bool isSignup = Provider.of<MyController>(context).isSignup;
    int duration = Provider.of<MyController>(context).duration;
    String Email = '';
    String Password = '';
    String ConfirmPassword = '';
    MyController provider = Provider.of<MyController>(context);

    return AnimatedPositioned(
      duration: Duration(milliseconds: duration),
      bottom: moveSignupCard, // -500
      left: 20,
      child: Transform.rotate(
        angle: pi + 0,
        child: CustomPaint(
          painter: BoxShadowPainter2(),
          child: ClipPath(
              clipper: CustomClip(),
              child: Container(
                width: 350,
                height: 650,
                padding: const EdgeInsets.only(left: 20, right: 10, bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Transform.rotate(
                  // Reverse Card Rotate
                  angle: pi,
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ArrowButton(
                            isSignup: isSignup,
                            color: kSecondryColor,
                            alignment: MainAxisAlignment.start,
                          ),
                          const SizedBox(height: 20),
                          const Logo(),
                          const SizedBox(height: 20),
                          customTextField(
                              lable: 'Name',
                              // cont: NameCon,
                              isPass: false,
                              validate: (value) {
                                if (value == null || value.isEmpty)
                                  return 'Field is Required';
                                return null;
                              },
                              icon: Icon(Icons.person)),
                          customTextField(
                            lable: 'Email',
                            // cont: EmaCon,
                            isPass: false,
                            icon: Icon(Icons.email),
                            onSaved: (value) {
                              Email = value!.trim();
                            },
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Field is Required';
                              } else if (!provider.isValidEmail(value)) {
                                return 'Enter Valid Email';
                              }
                              return null;
                            },
                          ),
                          customTextField(
                            lable: 'Password',
                            // cont: PassCon,
                            isPass: true,
                            icon: Icon(Icons.key),
                            onSaved: (value) {
                              Password = value!.trim();
                            },
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Field is Required';
                              } else if (!provider.isValidPassword(value)) {
                                return 'Enter Valid Password';
                              }
                              return null;
                            },
                          ),
                          customTextField(
                            lable: 'Confirm Password',
                            // cont: ConfPassCon,
                            isPass: true,
                            icon: Icon(Icons.key),
                            onSaved: (value) {
                              ConfirmPassword = value!.trim();
                            },
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Field is Required';
                              } else if (Password != ConfirmPassword) {
                                return 'Password not Match';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          GradientButton(
                            width: 200,
                            height: 55,
                            fontsize: 20,
                            lable: ' Signup',
                            alignment: MainAxisAlignment.end,
                            icon: const SizedBox(),
                            press: () async {
                              if (formKey.currentState!.validate()) {
                                try {
                                  formKey.currentState!.save();
                                  await Auth()
                                      .Register(Email, Password, context);
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  Provider.of<MyController>(context,
                                          listen: false)
                                      .animateCards(context);
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'email-already-in-use') {
                                    provider.Snakbar(
                                        context, 'Email Already Used');
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              } else {
                                // Navigator.pushReplacementNamed(context, LoginCard.id);
                                // provider.Snakbar(context, 'Erorr');
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
