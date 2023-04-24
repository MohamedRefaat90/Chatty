import 'package:chaty/Components/Chat/fullSizeImg.dart';
import 'package:chaty/Model/Message.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';

class ChatBubbleSender extends StatelessWidget {
  const ChatBubbleSender({
    super.key,
    required this.message,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: !message.isImage
          ? Container(
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  )),
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              child: Text(
                message.text,
                style: TextStyle(color: kWhite),
              ),
            )
          : message.text == 'Please Pick Image From Gallery'
              ? Container()
              : InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                fullSizeImg(message: message)));
                  },
                  child: Hero(
                    tag: message.text,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 10, left: 10),
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                      child: Image.network(
                        message.text,
                        width: 250,
                      ),
                    ),
                  ),
                ),
    );
  }
}

class ChatBubbleReciver extends StatelessWidget {
  const ChatBubbleReciver({
    super.key,
    required this.message,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: !message.isImage
          ? Container(
              decoration: BoxDecoration(
                  color: kSecondryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              child: Text(
                message.text,
                style: TextStyle(color: kWhite),
              ),
            )
          : message.text == 'Please Pick Image From Gallery'
              ? Container()
              : InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                fullSizeImg(message: message)));
                  },
                  child: Hero(
                    tag: message.text,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 10, right: 10),
                      decoration: BoxDecoration(
                          color: kSecondryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          )),
                      child: Image.network(message.text, width: 250,
                          frameBuilder:
                              (context, child, frame, wasSynchronouslyLoaded) {
                        return child;
                      }, loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Container(
                            width: 150,
                            height: 150,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                      }),
                    ),
                  ),
                ),
    );
  }
}
