import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import '../../../../../models/request_model.dart';
import '../../../../../utils/app_strings.dart';

class ProfileController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKeyProfile = GlobalKey<ScaffoldState>();
  TabController? tabController;
  TextEditingController name = TextEditingController();
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
          .child('profileImages/${DateTime.now().millisecondsSinceEpoch}');
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

  Future<void> addRequest(Request request) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('requests')
          .where('email', isEqualTo: request.email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
       Get.snackbar('Record Found Already!!', 'Request with this email already exists.');
        return;
      }
      var bytes = utf8.encode(request.password);
      var hashedPassword = sha256.convert(bytes).toString();
      Map<String, dynamic> requestData = request.toMap();
      requestData['password'] = hashedPassword;
      await FirebaseFirestore.instance
          .collection('requests')
          .add(requestData);
      Get.offAllNamed(kLogInRoute);
      
    } catch (e) {
      print("Error adding request: $e");
      Get.snackbar(
        "Error",
        "Error adding request."
        
      );
    }
  }
}
