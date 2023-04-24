import 'dart:math';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:chaty/Constants.dart';
import 'package:chaty/Controller/MyController.dart';

import '../../Screens/Chat.dart';
import '../../Services/Auth.dart';
import 'SocialButton.dart';

class LoginBySocial extends StatelessWidget {
  const LoginBySocial({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double moveTopSocialButtons =
        Provider.of<MyController>(context).moveSocialButtons;
    bool isSignup = Provider.of<MyController>(context).isSignup;
    int duration = Provider.of<MyController>(context).duration;
    TextEditingController phoneController = TextEditingController();
    String codeCountry = '';
    GlobalKey<FormState> formKey = GlobalKey();
    return AnimatedPositioned(
      duration: Duration(milliseconds: duration),
      bottom: moveTopSocialButtons,
      right: !isSignup ? 30 : -30,
      child: Transform.rotate(
        angle: pi + 10,
        child: Container(
          width: 400,
          height: 150,
          decoration: BoxDecoration(
              // color: const Color(0xffF7F7F7),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SocialButton(
                  circleColor: isSignup ? kWhite : kGoogleIcon,
                  iconColor: isSignup ? kGoogleIcon : kWhite,
                  icon: FontAwesomeIcons.googlePlusG,
                  press: () async {
                    if (!kIsWeb) {
                      // Android & IOS
                      var Email = await Auth.signInWithGoogle();

                      !isSignup
                          ? // Login
                          Navigator.pushReplacementNamed(context, ChatPage.id,
                              arguments: Email)
                          :
                          // Signup
                          Provider.of<MyController>(context, listen: false)
                              .animateCards(context);
                    } else {
                      // WEB
                      var x = await Auth().signinGoogleWeb();
                      // print(x.user!.email);
                      Navigator.pushReplacementNamed(context, ChatPage.id);
                    }
                  },
                ),
                SocialButton(
                  circleColor: isSignup ? kWhite : kFacebookIcon,
                  iconColor: isSignup ? kFacebookIcon : kWhite,
                  icon: FontAwesomeIcons.facebookF,
                  press: () async {
                    var user = (await Auth.signInWithFacebook());
                    String? Email = user!.user!.email;
                    !isSignup // Login
                        ? Navigator.pushReplacementNamed(context, ChatPage.id,
                            arguments: Email)
                        // Signup
                        : Provider.of<MyController>(context, listen: false)
                            .animateCards(context);
                  },
                ),
                SocialButton(
                  circleColor: isSignup ? kWhite : kTwitterIcon,
                  iconColor: isSignup ? kTwitterIcon : kWhite,
                  icon: FontAwesomeIcons.phone,
                  press: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                        actionsAlignment: MainAxisAlignment.center,
                        contentPadding: EdgeInsets.all(10),
                        title: Text(
                            isSignup ? 'Signup by Phone' : 'Login by Phone'),
                        content: Row(
                          children: [
                            CountryCodePicker(
                              onChanged: (value) {
                                codeCountry = value.dialCode!;
                              },
                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                              // initialSelection: 'EG',
                              // favorite: ['+02', 'EG'],
                              // optional. Shows only country name and flag
                              showCountryOnly: false,
                              // optional. Shows only country name and flag when popup is closed.
                              showOnlyCountryWhenClosed: false,
                              // optional. aligns the flag and the Text left
                              alignLeft: false,
                            ),
                            Expanded(
                              child: Form(
                                key: formKey,
                                child: TextFormField(
                                    validator: (value) {
                                      if (!Provider.of<MyController>(context,
                                              listen: false)
                                          .validatePhoneNumber(value!)) {
                                        return 'Invalid Phone Number';
                                      }

                                      return null;
                                    },
                                    controller: phoneController,
                                    decoration: InputDecoration(
                                        hintText: 'Enter Phone Number')),
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancle'),
                            textColor: kWhite,
                            color: kSecondryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          MaterialButton(
                            child: Text('Submit'),
                            color: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            textColor: kWhite,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                Auth.phoneSignin(
                                    context, phoneController.text, codeCountry);
                                Navigator.pushReplacementNamed(
                                    context, ChatPage.id,
                                    arguments: phoneController.text);
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
