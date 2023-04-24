import 'package:chaty/Controller/MyController.dart';
import 'package:chaty/Screens/Login&Signup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Components/Login/LoginCard.dart';
import 'Screens/Chat.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  if (kIsWeb) {
    // initialiaze the facebook javascript SDK
    await FacebookAuth.i.webAndDesktopInitialize(
      appId: "3022005921434686",
      cookie: true,
      xfbml: true,
      version: "v14.0",
    );
  } else {
    print('Facebook Auth Web Error');
  }

  runApp(const ChattyApp());
}

class ChattyApp extends StatelessWidget {
  const ChattyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(child: Login()),
        routes: {
          Login.id: (context) => Login(),
          ChatPage.id: (context) => ChatPage()
        },
      ),
    );
  }
}
