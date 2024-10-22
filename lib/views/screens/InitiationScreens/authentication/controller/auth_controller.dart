import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_cash_food/utils/app_strings.dart';

class AuthController extends GetxController {
  TextEditingController email = TextEditingController(),
      password = TextEditingController(),
      confirmPassword = TextEditingController(),
      loginEmail = TextEditingController(),
      loginPassword = TextEditingController();
  RxBool isLoading = false.obs;
  RxString loginMethod = ''.obs;
  final localStorage = GetStorage();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> login() async {
    try {
      isLoading.value = true;
      String loginEmailTrimmed = loginEmail.text.trim();
      print('Fetching user document for email: $loginEmailTrimmed');

      QuerySnapshot querySnapshot = await _db
          .collection('users')
          .where('email', isEqualTo: loginEmailTrimmed)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userDoc = querySnapshot.docs.first;
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        print('User document fetched: $userData');

        var bytes = utf8.encode(loginPassword.text);
        var hashedPassword = sha256.convert(bytes).toString();

        if (userData['password'] == hashedPassword) {
          print('Password matched');
          print(userDoc.id);
          localStorage.write('id', userDoc.id);
          localStorage.write('name', userData['name']);
          localStorage.write('email', userData['email']);
          localStorage.write('image', userData['image']);
          localStorage.write('password', userData['password']);
          localStorage.write('isTeamJoined', userData['isTeamJoined']);

          if (userData['isTeamJoined']) {
            QuerySnapshot teamSnapshot = await _db
                .collection('teams')
                .where('adminId', isEqualTo: userDoc.id)
                .limit(1)
                .get();

            if (teamSnapshot.docs.isNotEmpty) {
              DocumentSnapshot teamDoc = teamSnapshot.docs.first;
              localStorage.write('teamId', teamDoc.id);
              localStorage.write('adminId', teamDoc['adminId']);
              localStorage.write('mode', teamDoc['mode']);
              print('Team document fetched for admin: ${teamDoc.id}');
            } else {
              QuerySnapshot memberSnapshot = await _db
                  .collection('teams')
                  .where('members', arrayContains: userDoc.id)
                  .limit(1)
                  .get();

              if (memberSnapshot.docs.isNotEmpty) {
                DocumentSnapshot teamDoc = memberSnapshot.docs.first;
                localStorage.write('teamId', teamDoc.id);
                localStorage.write('adminId', teamDoc['adminId']);
                localStorage.write('mode', teamDoc['mode']);
                print('Team document fetched for member: ${teamDoc.id}');
              } else {
                print('No team found for this user');
              }
            }
            Get.offAllNamed(kNavBarRoute);
          } else {
            Get.offAllNamed(kCreateTeamRoute);
          }
        } else {
          print('Incorrect password');
          Get.snackbar('Error', 'Incorrect password');
        }
      } else {
        print('User does not exist');
        Get.snackbar('Error', 'User does not exist');
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print('Error occurred: $e');
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> handleGoogleSignIn() async {
    try {
      isLoading.value = true;
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        isLoading.value = false;
        Get.snackbar('Error', 'Google Sign-In canceled');
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String email = googleUser.email;
      final String displayName = googleUser.displayName ?? '';
      final String photoUrl = googleUser.photoUrl ?? '';

      print('Google Sign-In details: $email, $displayName, $photoUrl');

      QuerySnapshot userSnapshot = await _db.collection('users').where('email', isEqualTo: email).limit(1).get();

      if (userSnapshot.docs.isEmpty) {
        final userData = {
          'name': displayName,
          'email': email,
          'password': sha256.convert(utf8.encode(googleAuth.accessToken ?? '')).toString(),
          'image': photoUrl,
          'isTeamJoined': false,
        };

        DocumentReference newUser = await _db.collection('users').add(userData);

        localStorage.write('id', newUser.id);
        localStorage.write('name', displayName);
        localStorage.write('email', email);
        localStorage.write('image', photoUrl);
        localStorage.write('password', userData['password']);
        localStorage.write('isTeamJoined', false);

        Get.offAllNamed(kCreateTeamRoute);
      } else {
        DocumentSnapshot userDoc = userSnapshot.docs.first;
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        localStorage.write('id', userDoc.id);
        localStorage.write('name', userData['name']);
        localStorage.write('email', userData['email']);
        localStorage.write('image', userData['image']);
        localStorage.write('password', userData['password']);
        localStorage.write('isTeamJoined', userData['isTeamJoined']);

        if (userData['isTeamJoined']) {
          QuerySnapshot teamSnapshot = await _db
              .collection('teams')
              .where('adminId', isEqualTo: userDoc.id)
              .limit(1)
              .get();

          if (teamSnapshot.docs.isNotEmpty) {
            DocumentSnapshot teamDoc = teamSnapshot.docs.first;
            localStorage.write('teamId', teamDoc.id);
            localStorage.write('adminId', teamDoc['adminId']);
            localStorage.write('mode', teamDoc['mode']);
          } else {
            QuerySnapshot memberSnapshot = await _db
                .collection('teams')
                .where('members', arrayContains: userDoc.id)
                .limit(1)
                .get();

            if (memberSnapshot.docs.isNotEmpty) {
              DocumentSnapshot teamDoc = memberSnapshot.docs.first;
              localStorage.write('teamId', teamDoc.id);
              localStorage.write('adminId', teamDoc['adminId']);
              localStorage.write('mode', teamDoc['mode']);
            } else {
              print('No team found for this user');
            }
          }
          Get.offAllNamed(kNavBarRoute);
        } else {
          Get.offAllNamed(kCreateTeamRoute);
        }
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print('Error occurred during Google Sign-In: $e');
      Get.snackbar('Error', e.toString());
    }
  }
}
