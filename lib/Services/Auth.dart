import 'package:chaty/utilits/snakbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utilits/showOTPDialog.dart';

class Auth {
  late UserCredential user;

  // ============ Email Signup ========
  Future<void> Register(
      String Email, String Password, BuildContext context) async {
    user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: Email, password: Password);

    sendVerificationeEmail(context);
  }

  Future<void> sendVerificationeEmail(BuildContext context) async {
    try {
      user.user!.sendEmailVerification();
      showSnakBar(context, 'Email Verification Sent');
    } on FirebaseAuthException catch (e) {
      showSnakBar(context, e.message!);
    }
  }

  // ============ Email Signin ========
  Future<bool> Login(
      String Email, String Password, BuildContext context) async {
    user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: Email, password: Password);
    return user.user!.emailVerified;
  }

// ============ Google Sginin ========
  static Future<String?> signInWithGoogle() async {
    // if (!kIsWeb) {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    return googleUser!.id;
    //   } else {
    //     GoogleSignIn googleSignIn = GoogleSignIn(
    //       scopes: [
    //         'email',
    //         'https://www.googleapis.com/auth/contacts.readonly',
    //       ],
    //     );
    //     GoogleAuthProvider googleProvider = GoogleAuthProvider();
    //     googleProvider
    //         .addScope('https://www.googleapis.com/auth/contacts.readonly');
    //     try {
    //       await FirebaseAuth.instance.signInWithPopup(googleProvider);
    //       googleSignIn.signInSilently();
    //       return googleSignIn.currentUser!.id;
    //     } catch (error) {
    //       print(error);
    //       return null;
    //     }
    //   }
  }

  Future<UserCredential> signinGoogleWeb() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');

    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }

// ============ Facebook Sginin ========
  static Future<UserCredential?> signInWithFacebook() async {
    if (!kIsWeb) {
      try {
        final LoginResult result = await FacebookAuth.instance.login();
        if (result.status == LoginStatus.success) {
          // Create a credential from the access token
          final OAuthCredential credential =
              FacebookAuthProvider.credential(result.accessToken!.token);
          // Once signed in, return the UserCredential
          return await FirebaseAuth.instance.signInWithCredential(credential);
        }
        return null;
      } catch (e) {
        print(e);
      }
    } else {
      try {
        FacebookAuthProvider facebookProvider = FacebookAuthProvider();

        facebookProvider.addScope('email');
        facebookProvider.setCustomParameters({
          'display': 'popup',
        });

        // Once signed in, return the UserCredential
        return await FirebaseAuth.instance.signInWithPopup(facebookProvider);
      } catch (e) {
        print(e);
      }
    }
    return null;
  }

  // ============= Phone Signin ============

  static phoneSignin(
      BuildContext context, String phone, String codeCountry) async {
    TextEditingController otpCode = TextEditingController();
    String vrifiedPhone = '';
    if (phone.startsWith("0")) {
      vrifiedPhone = codeCountry + phone.substring(1);
      print(vrifiedPhone);
    }
// ================== for WEB =================
    if (kIsWeb) {
      // kIsWeb ===> From Foundation.dart
      FirebaseAuth auth = FirebaseAuth.instance;
      ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber(
        vrifiedPhone,
      );
      showOTPDialog(
          context: context,
          Code: otpCode,
          press: () async {
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: confirmationResult.verificationId,
                smsCode: otpCode.text.trim());

            await auth.signInWithCredential(credential);
            Navigator.of(context).pop();
          });
    } else {
      // ============= ANDROID & IOS ============

      FirebaseAuth auth = FirebaseAuth.instance;
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: vrifiedPhone,

        /* كودالرسالi بيخش تلقائي 
      this Function for Android .. When the SMS code is delivered to the device, 
      Android will automatically verify the SMS code 
      without requiring the user to manually input the code.

                  [Not Working for IOS]
      */
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            showSnakBar(context, 'The phone number is not valid.');
          }
        },
        /*
              بتدخل كود الرسالة  يدوي 
        When the SMS code is delivered to the device,  
        update your application UI to prompt the user to enter the SMS code they're expecting

                          [Working for IOS]
      */
        codeSent: (String verificationId, int? resendToken) {
          showOTPDialog(
              context: context,
              Code: otpCode,
              press: () async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: otpCode.text.trim());

                await auth.signInWithCredential(credential);
                Navigator.of(context).pop();
              });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  static Future<void> Signout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }
}
