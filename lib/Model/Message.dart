import 'package:cloud_firestore/cloud_firestore.dart';

import '../Constants.dart';

class Message {
  final String text;
  final String Email;
  final Timestamp date;
  final bool isImage;

  Message(this.text, this.Email, this.date, this.isImage);

  factory Message.fromJson(jsonData) {
    return Message(jsonData[kMessage], jsonData[kEmail], jsonData[KcreatedAt], jsonData['isImage']);
  }
}
