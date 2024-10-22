import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AddMemberController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKeyAddMember = GlobalKey<ScaffoldState>();
  String teamCode = ""; 

  @override
  void onInit() {
    super.onInit();
    fetchTeamCode();
  }

  void fetchTeamCode() async {
    try {
      String? teamId = GetStorage().read('teamId');
      if (teamId == null || teamId.isEmpty) {
        Get.snackbar("Error", "Team ID not found");
        return;
      }

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot teamDoc = await firestore.collection('teams').doc(teamId).get();

      if (teamDoc.exists) {
        Map<String, dynamic>? data = teamDoc.data() as Map<String, dynamic>?;
        if (data != null) {
          teamCode = data['code'] as String? ?? ""; 
          update(); 
        }
      } else {
        Get.snackbar("Error", "Team not found");
      }
    } catch (e) {
      print("Error fetching team code: $e");
    }
  }
}
