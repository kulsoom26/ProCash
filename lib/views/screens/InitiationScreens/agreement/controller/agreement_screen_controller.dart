import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_cash_food/models/team_model.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/selectattribute/controller/select_attribute_controller.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/selectmode/controller/select_mode_controller.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/teamprofile/controller/team_profile_controller.dart';

class AgreementController extends GetxController {
  var isChecked1 = false.obs;
  var isChecked2 = false.obs;
  var isChecked3 = false.obs;
  var isChecked4 = false.obs;
  var isLoading = false.obs;

  final TeamProfileController controller1 = Get.put(TeamProfileController());
  final SelectModeController controller2 = Get.put(SelectModeController());
  final SelectAttributeController controller3 = Get.put(SelectAttributeController());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GetStorage _storage = GetStorage();

  void toggleCheckbox1() {
    isChecked1.value = !isChecked1.value;
  }

  void toggleCheckbox2() {
    isChecked2.value = !isChecked2.value;
  }

  void toggleCheckbox3() {
    isChecked3.value = !isChecked3.value;
  }

  void toggleCheckbox4() {
    isChecked4.value = !isChecked4.value;
  }

  Future<void> createTeam() async {
    isLoading.value = true;
    try {
      final team = Team(
        code: controller1.teamCode.text.trim(),
        name: controller1.teamname.text.trim(),
        description: controller1.description.text.trim(),
        image: controller1.imagePath.value,
        mode: controller2.selectedIndex.value == 1 ? 'Basic Mode' : 'Location Mode',
        locations: controller2.selectedIndex.value == 2 ? ['My Warehouse'] : null,
        adminId: _storage.read('id'),
        attributes: controller3.selectedAttributes,
      );

      DocumentReference docRef = await _firestore.collection('teams').add(team.toMap());
      
      final newTeam = Team(
        id: docRef.id,
        code: team.code,
        name: team.name,
        description: team.description,
        image: team.image,
        mode: team.mode,
        locations: team.locations,
        adminId: team.adminId,
        attributes: team.attributes,
      );
      await _storage.write('teamId', newTeam.id);
      await _storage.write('adminId', newTeam.adminId);
      await _storage.write('mode', newTeam.mode);
      await _firestore.collection('users').doc(newTeam.adminId).update({
        'isTeamJoined': true,
      });
      _storage.write('isTeamJoined', true);

      Get.snackbar('Success', 'Team created successfully');
      Get.offAllNamed(kNavBarRoute);
    } catch (e) {
      Get.snackbar('Error', 'Failed to create team');
    } finally {
      isLoading.value = false;
    }
  }
}
