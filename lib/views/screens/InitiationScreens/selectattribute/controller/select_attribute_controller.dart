import 'package:get/get.dart';

import '../../../../../models/attributes_model.dart';

class SelectAttributeController extends GetxController {
  var selectedAttributes = <Attribute>[].obs;

  void toggleAttributeSelection(Attribute attribute) {
    if (selectedAttributes.contains(attribute)) {
      selectedAttributes.remove(attribute);
    } else {
      selectedAttributes.add(attribute);
    }
  }

  bool isSelected(Attribute attribute) {
    return selectedAttributes.contains(attribute);
  }
}