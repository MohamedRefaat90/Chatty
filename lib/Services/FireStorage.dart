import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FireStorage {
  final storage = FirebaseStorage.instance;
  ImagePicker picker = ImagePicker();
  late File file;

  Future<String> uploadImages(ImageSource sourceType) async {
    var pickedImage = await picker.pickImage(source: sourceType);

    if (pickedImage != null) {
      file = File(pickedImage.path); // Image

      // Get Image Name from The whole Path
      var imgName = basename(pickedImage.path);

      // Generate Random number to Prevent repeat image name
      var random = Random().nextInt(10000);

      // upload image
      Reference storageRef =
          storage.ref("Images/$random$imgName"); // Root to Store Images

      await storageRef.putFile(file);

      var getImg = await storageRef.getDownloadURL();
      // print(getImg);
      return getImg;
    } else {
      return 'Please Pick Image From Gallery';
    }
  }

  getImages() async {
    // get All files in Dictinory
    ListResult ref = await FirebaseStorage.instance.ref("Images").list();

    ref.items.forEach((element) {
      print(element.name);
    });
  }
}
