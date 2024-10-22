import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TeamProfileController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKeyTeamProfile = GlobalKey<ScaffoldState>();
  TextEditingController teamname = TextEditingController();
  TextEditingController teamCode = TextEditingController();
  TextEditingController description = TextEditingController();
  RxString imagePath = ''.obs;
  RxBool isUploading = false.obs;

  Future<void> getImageGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await uploadImage(File(image.path));
    }
  }

  Future<void> getImageCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      await uploadImage(File(image.path));
    }
  }

  Future<void> uploadImage(File imageFile) async {
    try {
      isUploading.value = true;
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('teamImages/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageURL = await taskSnapshot.ref.getDownloadURL();

      print(imageURL);
      imagePath.value = imageURL;
    } catch (e) {
      print("Error uploading image: $e");
    } finally {
      isUploading.value = false;
    }
  }
}
