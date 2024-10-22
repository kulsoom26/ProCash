import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_cash_food/models/items_model.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/Stocks/controller/stock_controller.dart';
import 'package:pro_cash_food/views/screens/ItemsScreens/Items/controller/items_controller.dart';
import '../../../../../models/attributes_model.dart';

class RegisterNewItemController extends GetxController {
  final scaffoldKeyRegisterNewItem = GlobalKey<ScaffoldState>();
  var isLoading = false.obs;
  ItemsController controller = Get.put(ItemsController());
  StockController controller1 = Get.put(StockController());

  final itemname = TextEditingController();
  final barcode = TextEditingController();
  final cost = TextEditingController();
  final price = TextEditingController();
  final quantity = TextEditingController();

  var toggleIndex = 0.obs;
  var teamAttributes = <Attribute>[].obs;
  var attributeControllers = <TextEditingController>[].obs;

  final GetStorage _storage = GetStorage();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    _loadTeamData();
  }

  void _loadTeamData() async {
    final teamId = _storage.read('teamId');
    if (teamId != null) {
      try {
        final teamDoc = await _firestore.collection('teams').doc(teamId).get();
        if (teamDoc.exists) {
          final teamData = teamDoc.data();
          if (teamData != null && teamData.containsKey('attributes')) {
            final attributes = List<Map<String, dynamic>>.from(teamData['attributes']);
            teamAttributes.assignAll(attributes.map((attr) => Attribute.fromMap(attr)).toList());
            attributeControllers.assignAll(
              teamAttributes.map((attr) => TextEditingController()).toList()
            );
          }
        }
      } catch (e) {
        print('Error fetching team data: $e');
      }
    }
  }

  RxString imagePath = ''.obs;
  RxBool isUploading = false.obs;

  Future<void> getImageGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await uploadImage(File(image.path));
    }
  }

  Future<void> getImageCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      await uploadImage(File(image.path));
    }
  }

  Future<void> uploadImage(File imageFile) async {
    try {
      isUploading.value = true;
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('itemImages/${DateTime.now().millisecondsSinceEpoch}');
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

  bool areAllAttributeFieldsFilled() {
    for (var controller in attributeControllers) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  Future<void> addItemToFirestore() async {
  isLoading.value = true; 

  try {
    final attributes = <Map<String, String>>[];
    for (int i = 0; i < teamAttributes.length; i++) {
      attributes.add({
        'name': teamAttributes[i].name,
        'value': attributeControllers[i].text,
      });
    }

    final newItem = Item(
      teamId: _storage.read('teamId') ?? '',
      name: itemname.text,
      barcode: barcode.text,
      cost: double.tryParse(cost.text) ?? 0.0,
      price: double.tryParse(price.text) ?? 0.0,
      image: imagePath.value,
      quantity: int.tryParse(quantity.text) ?? 0,
      attributes: attributes,
    );

    await _firestore.collection('items').add(newItem.toMap());
    controller.fetchItems();
    controller1.fetchItems();
    Get.snackbar('Success', '${itemname.text} has been successfully added into items!!');

    
  } catch (e) {
    Get.snackbar('Error', '${itemname.text} failed to be added in the items!!');
  } finally {
    isLoading.value = false; 
  }
}


  String generateRandomBarcode() {
    final random = Random();
    final barcode = List.generate(13, (index) => random.nextInt(10)).join();
    return barcode;
  }

  void addAttribute(Attribute attribute) {
    teamAttributes.add(attribute);
    attributeControllers.add(TextEditingController());
    print('Attribute added: $attribute');
    print('Current attributes: $teamAttributes');
    print('Current controllers: ${attributeControllers.length}');
  }

  void removeAttribute(String attributeName) {
    final index = teamAttributes.indexWhere((attr) => attr.name == attributeName);
    if (index != -1) {
      teamAttributes.removeAt(index);
      attributeControllers.removeAt(index);
      print('Attribute removed: $attributeName');
      print('Current attributes: $teamAttributes');
      print('Current controllers: ${attributeControllers.length}');
    }
  }
}
