import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../Constants.dart';
import '../../Services/FireStorage.dart';

class ChatTextField extends StatelessWidget {
  ChatTextField({
    super.key,
    required this.txtCon,
    required this.Messages,
    required this.scrollCon,
    required this.Email,
  });

  final TextEditingController txtCon;
  final CollectionReference<Object?> Messages;
  final ScrollController scrollCon;
  final String Email;

  @override
  Widget build(BuildContext context) {
    // print("==============$Email==============");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: txtCon,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: kPrimaryColor, width: 3)),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    if (txtCon.text.isNotEmpty)
                      Messages.add({
                        kMessage: txtCon.text,
                        KcreatedAt: DateTime.now(),
                        kEmail: Email,
                        "isImage": false
                      });
                    scrollCon.animateTo(0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                    txtCon.clear();
                  },
                  icon: Icon(Icons.send),
                  color: kSecondryColor,
                ),
                IconButton(
                  onPressed: () async {
                    FireStorage uploadImage = FireStorage();
                    String imgURL =
                        await uploadImage.uploadImages(ImageSource.camera);
                    Messages.add({
                      kMessage: imgURL,
                      KcreatedAt: DateTime.now(),
                      kEmail: Email,
                      "isImage": true
                    });
                  },
                  icon: Icon(Icons.camera_alt_sharp),
                  color: kSecondryColor,
                ),
                IconButton(
                  onPressed: () async {
                    FireStorage uploadImage = FireStorage();
                    String imgURL =
                        await uploadImage.uploadImages(ImageSource.gallery);
                    // print(imgURL);

                    Messages.add({
                      kMessage: imgURL,
                      KcreatedAt: DateTime.now(),
                      kEmail: Email,
                      "isImage": true
                    });
                    // await uploadImage.uploadImages(ImageSource.gallery);
                    // await uploadImage.getImages();
                  },
                  icon: Icon(Icons.attach_file),
                  color: kSecondryColor,
                ),
              ],
            )),
        onSubmitted: (value) {
          // print("==============$Email==============");
          if (value.isNotEmpty)
            Messages.add({
              kMessage: value,
              kEmail: Email,
              KcreatedAt: DateTime.now(),
              "isImage": false
            });

          scrollCon.animateTo(0,
              duration: Duration(milliseconds: 500), curve: Curves.easeIn);

          txtCon.clear();
        },
      ),
    );
  }
}
