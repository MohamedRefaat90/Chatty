import 'package:chaty/Components/Chat/ChatTextField.dart';
import 'package:chaty/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/Chat/ChatBubble.dart';
import '../Model/Message.dart';
import '../Services/Auth.dart';
import 'Login&Signup.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  static String id = 'ChatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference Messages =
      FirebaseFirestore.instance.collection('Messages');
  TextEditingController txtCon = TextEditingController();
  final scrollCon = ScrollController();
  // String? Email;
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    // Email = email;

    return StreamBuilder(
        stream: Messages.orderBy(KcreatedAt, descending: true)
            .snapshots(), // Stream of Data
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // print(snapshot.data!.docs[1][kMessage]);

            // List of all Document from firestore
            List<Message> messagesList = [];

            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              // place all Documents from firestore to model then return text of message
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Chatty',
                    style: GoogleFonts.pacifico(fontSize: 25),
                  ),
                  centerTitle: true,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [kPrimaryColor, kSecondryColor])),
                  ),
                  leading: IconButton(
                      onPressed: () async {
                        await Auth.Signout();
                        print("Logout done");
                        Navigator.pushReplacementNamed(context, Login.id);
                      },
                      icon: Icon(Icons.output)),
                ),
                body: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            reverse: true,
                            controller: scrollCon,
                            itemCount: messagesList.length,
                            itemBuilder: (context, index) => messagesList[index]
                                        .Email == email
                                ? ChatBubbleSender(message: messagesList[index])
                                : ChatBubbleReciver(
                                    message: messagesList[index],
                                  ))),
                    ChatTextField(
                        txtCon: txtCon,
                        Messages: Messages,
                        Email: email,
                        scrollCon: scrollCon)
                  ],
                ));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
