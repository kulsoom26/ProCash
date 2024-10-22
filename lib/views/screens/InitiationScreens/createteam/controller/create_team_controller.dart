import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_cash_food/utils/app_strings.dart';

class CreateTeamController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKeyCreateTeam = GlobalKey<ScaffoldState>();
  TextEditingController code = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GetStorage _storage = GetStorage();

  Future<void> joinTeam() async {
    try {
      final String teamCode = code.text.trim();
      final String userId = _storage.read('id') ?? '';

      if (teamCode.isEmpty) {
        Get.snackbar('Error', 'Please enter a team code.');
        return;
      }

      final QuerySnapshot teamSnapshot = await _firestore
          .collection('teams')
          .where('code', isEqualTo: teamCode)
          .get();

      if (teamSnapshot.docs.isEmpty) {
        Get.snackbar('Error', 'Team not found or invalid code.');
        return;
      }

      final DocumentSnapshot teamDoc = teamSnapshot.docs.first;
      final String teamId = teamDoc.id;
      final List<dynamic> members = teamDoc['members'];

      if (members.contains(userId)) {
        Get.snackbar('Error', 'You are already a member of this team.');
        return;
      }
      await _firestore.collection('teams').doc(teamId).update({
        'members': FieldValue.arrayUnion([userId]),
      });
      await _firestore.collection('users').doc(userId).update({
        'isTeamJoined': true,
      });

      final String adminId = teamDoc['adminId'];
      final String mode = teamDoc['mode'];

      _storage.write('isTeamJoined', true);
      _storage.write('teamId', teamId);
      _storage.write('adminId', adminId);
      _storage.write('mode', mode);

      Get.snackbar('Success', 'You have joined the team!');
      Get.offAllNamed(kNavBarRoute);
    } catch (e) {
      Get.snackbar('Error', 'Failed to join the team: $e');
    }
  }
}
