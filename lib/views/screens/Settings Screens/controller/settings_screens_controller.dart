import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro_cash_food/models/customers_model.dart';
import 'package:pro_cash_food/utils/app_images.dart';
import 'package:pro_cash_food/utils/app_strings.dart';

import '../../../../models/notes_model.dart';
import '../../../../models/suppliers_model.dart';
import '../../../../models/team_model.dart';
import '../../../../models/user_model.dart';

class SettingsController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKeySettings = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeyCurrency = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeyTimezone = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeyMembers = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeyMemberInvite = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeyManageRoles = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeyAddNewRole = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeyMyTeams = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeyDisplayFormat =
      GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeyItems = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeyAddItem = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeySupplierCustomerList =
      GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeyEditSupplierCustomer =
      GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeyAddSupplierCustomer =
      GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeyLocations = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeyAddlocation = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKeyUserProfiling =
      GlobalKey<ScaffoldState>();

  // Settings Controllers
  RxString timezone = 'GMT + 05:00'.obs;
  RxString members = ' Members'.obs;
  RxString items = '9 Attributes'.obs;
  RxString suppliers = '4 Suppliers'.obs;
  RxString customers = '19 Customers'.obs;
  RxString location = '89 Locations'.obs;
  RxString format = ''.obs;
  RxString teamName = ''.obs;
  RxInt itemQuantity = 0.obs;
  RxInt teamLocations = 0.obs;
  RxInt teamMembers = 0.obs;
  RxList<Team> teamData = <Team>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTeamData();
    fetchTeamCode();
    fetchTeamsForUser();
    fetchSuppliers();
    fetchCustomers();
    fetchLocations();
  }

  Future<void> fetchTeamData() async {
    try {
      final teamId = GetStorage().read('teamId');

      if (teamId == null) {
        Get.snackbar('Error', 'No team ID found in storage.');
        return;
      }
      final teamDoc = await FirebaseFirestore.instance
          .collection('teams')
          .doc(teamId)
          .get();

      if (teamDoc.exists) {
        final data = teamDoc.data()!;
        print('Fetched team data: $data');
        final team = Team.fromMap(teamDoc.id, data);
        teamName.value = team.name;
        teamLocations.value = team.locations?.length ?? 0;
        teamMembers.value = team.members.length;
        teamData.clear();
        teamData.add(team);
        print('Team data stored in RxList: ${teamData[0]}');

        final itemsSnapshot = await FirebaseFirestore.instance
            .collection('items')
            .where('teamId', isEqualTo: teamId)
            .get();

        if (itemsSnapshot.docs.isNotEmpty) {
          int totalQuantity = 0;
          for (var doc in itemsSnapshot.docs) {
            final itemData = doc.data();
            final itemQuantity = itemData['quantity'] ?? 0;
            totalQuantity += (itemQuantity as num).toInt();
          }
          itemQuantity.value = totalQuantity;
          print('Total quantity: $totalQuantity');
        } else {
          Get.snackbar('Info', 'No items found for the team.');
          itemQuantity.value = 0;
        }
        await fetchTeamMembersDetails(team.members);
        members.value = '${existingMembers.length} Members';
      } else {
        Get.snackbar('Error', 'No team found with the provided ID.');
      }
    } catch (e) {
      print('Error fetching team data: $e');
      Get.snackbar('Error', 'Failed to fetch team data.');
    }
  }

  TextEditingController changeTeamName = TextEditingController();

  Future<void> updateTeamName() async {
    try {
      String teamId = GetStorage().read('teamId');
      await FirebaseFirestore.instance
          .collection('teams')
          .doc(teamId)
          .update({
        'name': changeTeamName.text.trim(),
      });
      fetchTeamData();
      Get.snackbar('Updated successfully!', 'Team name updated successfully');
      changeTeamName.text = '';
      print('Team name updated successfully');
        } catch (e) {
      changeTeamName.text = '';
      print('Error updating team name: $e');
    }
  }

  TextEditingController notes = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxString dummyNote = 'Note'.obs;

  Future<void> addNoteToFirestore(Notes note) async {
    try {
      await _firestore.collection('notes').add(note.toMap());
      Get.snackbar('Added successfully!', 'Note has been added to your team');
      dummyNote.value = notes.text.trim();
      notes.text = '';
      print('Note added successfully');
    } catch (e) {
      notes.text = '';
      print('Error adding note: $e');
    }
  }

  Future<void> fetchTeamMembersDetails(List<String> memberIds) async {
    try {
      if (memberIds.isEmpty) {
        existingMembers.clear();
        return;
      }

      final memberDocs = await FirebaseFirestore.instance
          .collection('users')
          .where(FieldPath.documentId, whereIn: memberIds)
          .get();

      final List<Map<String, dynamic>> membersDetails =
          memberDocs.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          'name': data['name'] ?? 'Unknown',
          'image': data['image'] ?? '',
          'email': data['email']
        };
      }).toList();

      existingMembers.value = membersDetails;
      print('Fetched team members details: $membersDetails');
    } catch (e) {
      print('Error fetching team members details: $e');
      Get.snackbar('Error', 'Failed to fetch team members details.');
    }
  }

  Future<void> deleteMemberFromTeam(String memberId) async {
    try {
      final teamId = GetStorage().read('teamId');
      if (teamId == null) {
        Get.snackbar('Error', 'No team ID found in storage.');
        return;
      }

      final teamDoc = await FirebaseFirestore.instance
          .collection('teams')
          .doc(teamId)
          .get();

      if (!teamDoc.exists) {
        Get.snackbar('Error', 'Team not found.');
        return;
      }

      final team = Team.fromMap(teamDoc.id, teamDoc.data()!);

      if (!team.members.contains(memberId)) {
        Get.snackbar('Error', 'Member not found in team.');
        return;
      }

      final updatedMembers = List<String>.from(team.members)..remove(memberId);

      await FirebaseFirestore.instance.collection('teams').doc(teamId).update({
        'members': updatedMembers,
      });
      final adminTeamsSnapshot = await FirebaseFirestore.instance
          .collection('teams')
          .where('adminId', isEqualTo: memberId)
          .get();

      if (adminTeamsSnapshot.docs.isNotEmpty) {
        existingMembers.removeWhere((member) => member['id'] == memberId);
        members.value = '${existingMembers.length} Members';
        Get.snackbar('Success', 'Member removed from team successfully.');
        print('Member removed from team successfully.');
        return;
      }
      final otherTeamsSnapshot = await FirebaseFirestore.instance
          .collection('teams')
          .where('members', arrayContains: memberId)
          .get();

      if (otherTeamsSnapshot.docs.isNotEmpty) {
        existingMembers.removeWhere((member) => member['id'] == memberId);
        members.value = '${existingMembers.length} Members';
        fetchTeamData();
        fetchTeamsForUser();
        Get.snackbar('Success', 'Member removed from team successfully.');
        print('Member removed from team successfully.');
        return;
      }

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(memberId)
          .get();

      if (userDoc.exists) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(memberId)
            .update({
          'isTeamJoined': false,
        });
      }

      existingMembers.removeWhere((member) => member['id'] == memberId);
      members.value = '${existingMembers.length} Members';
      Get.snackbar('Success', 'Member removed from team successfully.');
      print('Member removed from team successfully.');
    } catch (e) {
      print('Error removing member from team: $e');
      Get.snackbar('Error', 'Failed to remove member from team.');
    }
  }

  //Timezone Controllers
  RxList<String> timezones = <String>[
    'Samoa Standard Time (GMT - 11:00)',
    'Niue Time (GMT - 11:00)',
    'HawaiiAleutian (GMT - 10:00)',
    'Tahiti Time (GMT - 10:00)',
    'Marquesan Time (GMT - 09:30)',
    'Standard Time (GMT - 11:00)',
    'Samoa Standard (GMT - 11:00)',
    'Samoa Time (GMT - 11:00)',
  ].obs;

  //Timezone Controllers
  RxList<Map<String, dynamic>> currency = <Map<String, dynamic>>[
    {'image': kAlgerianFlag, 'name': 'Algerian Dinar (DZD)', 'symbol': 'د.ج'},
    {'image': kAfghanFlag, 'name': 'Afghan Afghani (AFN)', 'symbol': '؋'},
    {'image': kAlbanianFlag, 'name': 'Albanian Lek (ALL)', 'symbol': 'L'},
    {'image': kEuroFlag, 'name': 'Euro (EUR)', 'symbol': '€'},
    {'image': kAngolanFlag, 'name': 'Angolan Kwanza (AOA)', 'symbol': 'Kz'},
    {
      'image': kCaribbeanFlag,
      'name': 'Eastern Caribbean Dollar (XCD)',
      'symbol': '\$'
    },
    {
      'image': kAustralianFlag,
      'name': 'Australian Dollar (AUD)',
      'symbol': 'A\$'
    },
    {'image': kArgentineFlag, 'name': 'Argentine Peso (ARS)', 'symbol': '\$'}
  ].obs;

  RxString selectedCurrency = ''.obs;

  // Members Controllers
  RxList<Map<String, dynamic>> existingMembers = <Map<String, dynamic>>[].obs;
  RxString teamCode = "".obs;

  // Manage roles Controllers
  TextEditingController roleName = TextEditingController();
  RxList<Map<String, dynamic>> featureAccess = <Map<String, dynamic>>[
    {'name': "Manage Item", 'active': true.obs},
    {'name': "Manage Attribute", 'active': true.obs},
    {'name': "Manage Partner", 'active': true.obs},
    {'name': "Manage Location", 'active': true.obs},
    {'name': "Stock In", 'active': true.obs},
    {'name': "Stock Out", 'active': true.obs},
    {'name': "Move Stock", 'active': true.obs},
    {'name': "Adjust", 'active': true.obs},
    {'name': "Manage Stock In Draft", 'active': true.obs},
    {'name': "Manage Stock Out Draft", 'active': true.obs},
  ].obs;
  RxList<Map<String, dynamic>> itemAttributeAccess = <Map<String, dynamic>>[
    {'name': "Type", 'active': true.obs},
    {'name': "Brand", 'active': true.obs},
    {'name': "Manufacturer", 'active': true.obs},
    {'name': "Color", 'active': true.obs},
    {'name': "Size", 'active': true.obs},
    {'name': "Storage", 'active': true.obs},
    {'name': "Lot Number", 'active': true.obs},
    {'name': "Note", 'active': true.obs},
    {'name': "Safety Stock", 'active': true.obs},
  ].obs;

  // My Teams Controller
  RxList<Map<String, dynamic>> teams = <Map<String, dynamic>>[
    // {
    //   'image': kTeam1,
    //   'name': 'Team 1',
    //   'description':
    //       'Lorem ipsum dolor sit amet consectetur. Leo tempor eget scelerisque libero.',
    //   'item': 120,
    //   'members': 23,
    //   'location': 54,
    //   'mode': 'Basic Mode'
    // },
    // {
    //   'image': kTeam2,
    //   'name': 'Team 2',
    //   'description':
    //       'Lorem ipsum dolor sit amet consectetur. Leo tempor eget scelerisque libero.',
    //   'item': 345,
    //   'members': 34,
    //   'location': 76,
    //   'mode': 'Location Mode'
    // },
  ].obs;

  Future<void> fetchTeamsForUser() async {
    try {
      final userId = GetStorage().read('id');
      if (userId == null) {
        Get.snackbar('Error', 'No user ID found in storage.');
        return;
      }

      final teamsSnapshot = await FirebaseFirestore.instance
          .collection('teams')
          .where('adminId', isEqualTo: userId)
          .get();

      final memberTeamsSnapshot = await FirebaseFirestore.instance
          .collection('teams')
          .where('members', arrayContains: userId)
          .get();
      final allTeamDocs = <DocumentSnapshot>[...teamsSnapshot.docs]
        
        ..addAll(memberTeamsSnapshot.docs);

      final List<Map<String, dynamic>> teamsDetails = [];

      for (var teamDoc in allTeamDocs) {
        final data = teamDoc.data() as Map<String, dynamic>?;
        final teamId = teamDoc.id;

        if (data == null) {
          print('No data found for team with ID: $teamId');
          continue;
        }

        final team = Team.fromMap(teamId, data);
        final itemsSnapshot = await FirebaseFirestore.instance
            .collection('items')
            .where('teamId', isEqualTo: teamId)
            .get();

        int totalQuantity = 0;
        if (itemsSnapshot.docs.isNotEmpty) {
          for (var doc in itemsSnapshot.docs) {
            final itemData = doc.data();
            final itemQuantity = itemData['quantity'] ?? 0;
            totalQuantity += (itemQuantity as num).toInt();
          }
        }

        teamsDetails.add({
          'id': teamId,
          'name': team.name,
          'description': team.description,
          'mode': team.mode,
          'adminId': team.adminId,
          'image': team.image,
          'totalItems': totalQuantity,
          'totalMembers': team.members.length,
          'totalLocations': team.locations?.length ?? 0,
        });
      }

      teams.value = teamsDetails;
      print('Fetched teams details: $teamsDetails');
    } catch (e) {
      print('Error fetching teams for user: $e');
      Get.snackbar('Error', 'Failed to fetch teams for user.');
    }
  }

  // Display Format
  RxList<String> displayFormat = <String>[
    'Cost & Price + All Attributes',
    'All Attributes + Cost & Price',
    'All Attributes',
    'Barcode',
  ].obs;

  //Items
  RxList<Map<String, dynamic>> itemAttribute = <Map<String, dynamic>>[
    {'name': 'Type', 'type': 'Text'},
    {'name': 'Brand', 'type': 'Text'},
    {'name': 'Manufacturer', 'type': 'Text'},
    {'name': 'Color', 'type': 'Text'},
    {'name': 'Size', 'type': 'Number'},
    {'name': 'Storage', 'type': 'Text'},
    {'name': 'Lot Number', 'type': 'Text'},
    {'name': 'Description', 'type': 'Text'},
  ].obs;

  void renameAttribute(Map<String, dynamic> data, String newName) {
    int index = itemAttribute.indexOf(data);
    if (index != -1) {
      itemAttribute[index]['name'] = newName;
      itemAttribute.refresh();
    }
  }

  void deleteAttribute(Map<String, dynamic> data) {
    itemAttribute.remove(data);
  }

  //Add Attribute
  TextEditingController attributeName = TextEditingController(),
      attributeType = TextEditingController();

  var suppliersList = <Supplier>[].obs;
  var customersList = <Customer>[].obs;

  Future<void> fetchSuppliers() async {
    try {
      final teamId = GetStorage().read('teamId');

      if (teamId == null) {
        Get.snackbar(
          'Error',
          'No team ID found in storage.',
        );
        return;
      }

      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('suppliers')
          .where('teamId', isEqualTo: teamId)
          .get();

      final List<Supplier> supplierList = snapshot.docs
          .map((doc) => Supplier.fromMap({
                ...doc.data() as Map<String, dynamic>,
                'id': doc.id,
              }))
          .toList();

      suppliersList.value = supplierList;
      suppliers.value = '${suppliersList.length} Suppliers';
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch suppliers: $e',
      );
    }
  }

  Future<void> fetchCustomers() async {
    try {
      final teamId = GetStorage().read('teamId');

      if (teamId == null) {
        Get.snackbar(
          'Error',
          'No team ID found in storage.',
        );
        return;
      }
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('customers')
          .where('teamId', isEqualTo: teamId)
          .get();
      final List<Customer> customerList = snapshot.docs
          .map((doc) => Customer.fromMap({
                ...doc.data() as Map<String, dynamic>,
                'id': doc.id,
              }))
          .toList();
      customersList.value = customerList;
      customers.value = '${customersList.length} Customers';
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch suppliers: $e',
      );
    }
  }

  Future<void> deleteSupplier(String supplierId, String name) async {
    try {
      final supplierDoc = await FirebaseFirestore.instance
          .collection('suppliers')
          .doc(supplierId)
          .get();

      final teamId = GetStorage().read('teamId');

      if (teamId == null) {
        Get.snackbar(
          'Error',
          'Team ID not found for the supplier.',
        );
        return;
      }

      await FirebaseFirestore.instance
          .collection('suppliers')
          .doc(supplierId)
          .delete();
      suppliersList.removeWhere((supplier) => supplier.id == supplierId);

      await FirebaseFirestore.instance.collection('teams').doc(teamId).update({
        'suppliers': FieldValue.arrayRemove([name]),
      });

      suppliers.value = '${suppliersList.length} Suppliers';

      Get.snackbar(
        'Success',
        'Supplier deleted successfully.',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete supplier: $e',
      );
    }
  }

  Future<void> deleteCustomer(String customerId, String name) async {
    try {
      final customerDoc = await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerId)
          .get();

      final teamId = GetStorage().read('teamId');

      if (teamId == null) {
        Get.snackbar(
          'Error',
          'Team ID not found for the customer.',
        );
        return;
      }

      await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerId)
          .delete();
      customersList.removeWhere((customer) => customer.id == customerId);

      await FirebaseFirestore.instance.collection('teams').doc(teamId).update({
        'customers': FieldValue.arrayRemove([name]),
      });

      customers.value = '${customersList.length} Customers';

      Get.snackbar(
        'Success',
        'Customer deleted successfully.',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete Customer: $e',
      );
    }
  }

  var teamId = GetStorage().read('teamId');
  void addSupplier(Supplier supplier) async {
    try {
      await FirebaseFirestore.instance.collection('teams').doc(teamId).update({
        'suppliers': FieldValue.arrayUnion([supplier.name]),
      });
      final newItem = Supplier(
          name: supplier.name,
          teamId: GetStorage().read('teamId'),
          email: supplier.email,
          telephone: supplier.telephone,
          address: supplier.address,
          description: supplier.description);
      await FirebaseFirestore.instance
          .collection('suppliers')
          .add(newItem.toMap());
      fetchSuppliers();
      Get.snackbar("Successful!!", 'Supplier added successfully');
    } catch (e) {
      Get.snackbar("Error!!", 'Error adding customer: $e');
      print('Error adding location: $e');
    }
  }

  void addCustomer(Customer customer) async {
    try {
      await FirebaseFirestore.instance.collection('teams').doc(teamId).update({
        'customers': FieldValue.arrayUnion([customer.name]),
      });
      final newItem = Customer(
          name: customer.name,
          teamId: GetStorage().read('teamId'),
          email: customer.email,
          telephone: customer.telephone,
          address: customer.address,
          description: customer.description);
      await FirebaseFirestore.instance
          .collection('customers')
          .add(newItem.toMap());
      fetchCustomers();
      Get.snackbar("Successful!!", 'Customer added successfully');
    } catch (e) {
      Get.snackbar("Error!!", 'Error adding customer: $e');
      print('Error adding customer: $e');
    }
  }

  Future<void> updateCustomer(
      String customerId, Customer updatedCustomer) async {
    try {
      final customerDoc = await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerId)
          .get();

      final teamId = customerDoc.data()?['teamId'];

      if (teamId == null) {
        Get.snackbar(
          'Error',
          'Team ID not found for the customer.',
        );
        return;
      }

      await FirebaseFirestore.instance
          .collection('customers')
          .doc(customerId)
          .update(updatedCustomer.toMap());
      final oldCustomerName = customerDoc.data()?['name'];

      if (oldCustomerName != updatedCustomer.name) {
        await FirebaseFirestore.instance
            .collection('teams')
            .doc(teamId)
            .update({
          'customers': FieldValue.arrayRemove([oldCustomerName]),
        });

        await FirebaseFirestore.instance
            .collection('teams')
            .doc(teamId)
            .update({
          'customers': FieldValue.arrayUnion([updatedCustomer.name]),
        });
      }

      fetchCustomers();

      Get.snackbar(
        'Successful!!',
        'Customer updated successfully',
      );
    } catch (e) {
      Get.snackbar(
        'Error!!',
        'Error updating customer: $e',
      );
      print('Error updating customer: $e');
    }
  }

  Future<void> updateSupplier(
      String supplierId, Supplier updatedSupplier) async {
    try {
      final supplierDoc = await FirebaseFirestore.instance
          .collection('suppliers')
          .doc(supplierId)
          .get();

      final teamId = supplierDoc.data()?['teamId'];
      final oldSupplierName = supplierDoc.data()?['name'];

      if (teamId == null) {
        Get.snackbar(
          'Error',
          'Team ID not found for the supplier.',
        );
        return;
      }

      await FirebaseFirestore.instance
          .collection('suppliers')
          .doc(supplierId)
          .update(updatedSupplier.toMap());

      if (oldSupplierName != updatedSupplier.name) {
        await FirebaseFirestore.instance
            .collection('teams')
            .doc(teamId)
            .update({
          'suppliers': FieldValue.arrayRemove([oldSupplierName]),
        });

        await FirebaseFirestore.instance
            .collection('teams')
            .doc(teamId)
            .update({
          'suppliers': FieldValue.arrayUnion([updatedSupplier.name]),
        });
      }

      fetchSuppliers();

      Get.snackbar(
        'Successful!!',
        'Supplier updated successfully',
      );
    } catch (e) {
      Get.snackbar(
        'Error!!',
        'Error updating supplier: $e',
      );
      print('Error updating supplier: $e');
    }
  }

  //Edit Supplier/customer
  TextEditingController name = TextEditingController(),
      email = TextEditingController(),
      address = TextEditingController(),
      description = TextEditingController(),
      telephone = TextEditingController();

  //Add Supplier/customer
  TextEditingController nameAdd = TextEditingController(),
      emailAdd = TextEditingController(),
      addressAdd = TextEditingController(),
      descriptionAdd = TextEditingController(),
      telephoneAdd = TextEditingController();

  //Locations
  RxList<Map<String, dynamic>> locations = <Map<String, dynamic>>[
    {
      'name': 'Warehouse1',
      'image': kWarehouse,
      'description':
          'Lorem ipsum dolor sit amet consectetur. Ipsum sed porttitor ac laoreet proin quis lobortis enim. Arcu et sit neque pellentesque. Facilisis vestibulum nulla in enim risus etiam volutpat blandit. Dui mauris eu feugiat enim.'
    },
    {
      'name': 'Warehouse2',
      'image': kWarehouse,
      'description':
          'Lorem ipsum dolor sit amet consectetur. Ipsum sed porttitor ac laoreet proin quis lobortis enim. Arcu et sit neque pellentesque. Facilisis vestibulum nulla in enim risus etiam volutpat blandit. Dui mauris eu feugiat enim.'
    },
    {
      'name': 'Warehouse3',
      'image': kWarehouse,
      'description':
          'Lorem ipsum dolor sit amet consectetur. Ipsum sed porttitor ac laoreet proin quis lobortis enim. Arcu et sit neque pellentesque. Facilisis vestibulum nulla in enim risus etiam volutpat blandit. Dui mauris eu feugiat enim.'
    },
  ].obs;

  Future<void> fetchLocations() async {
  try {
    final teamId = GetStorage().read('teamId');

    if (teamId == null) {
      Get.snackbar(
        'Error',
        'No team ID found in storage.',
      );
      return;
    }

    // Fetch the team document
    DocumentSnapshot teamDoc = await FirebaseFirestore.instance
        .collection('teams')
        .doc(teamId)
        .get();

    if (teamDoc.exists) {
      List<dynamic> locationsList = teamDoc['locations'] ?? [];
      locations.value = locationsList.map((location) {
        return {
          'name': location.toString(),
          'image': kWarehouse,
        };
      }).toList();
      // Get.snackbar(
      //   'Success',
      //   '${locations.length} Locations fetched successfully.',
      // );
      location.value = '${locationsList.length} Locations';
    } else {
      Get.snackbar(
        'Error',
        'Team document does not exist.',
      );
    }
  } catch (e) {
    Get.snackbar(
      'Error',
      'Error fetching locations: $e',
    );
    print('Error fetching locations: $e');
  }
}


  Future<void> deleteLocation(String locationName) async {
  try {
    final teamId = GetStorage().read('teamId');

    if (teamId == null) {
      Get.snackbar(
        'Error',
        'No team ID found in storage.',
      );
      return;
    }

    // Fetch the team document
    DocumentSnapshot teamDoc = await FirebaseFirestore.instance
        .collection('teams')
        .doc(teamId)
        .get();

    if (teamDoc.exists) {
      List<dynamic> locationsList = teamDoc['locations'] ?? [];
      
      if (locationsList.contains(locationName)) {
        // Remove the location from Firestore
        await FirebaseFirestore.instance.collection('teams').doc(teamId).update({
          'locations': FieldValue.arrayRemove([locationName]),
        });

        locations.removeWhere((location) => location['name'] == locationName);

        Get.snackbar(
          'Success',
          'Location deleted successfully.',
        );
        fetchLocations();
      } else {
        Get.snackbar(
          'Error',
          'Location not found.',
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'Team document does not exist.',
      );
    }
  } catch (e) {
    Get.snackbar(
      'Error',
      'Failed to delete location: $e',
    );
    print('Error deleting location: $e');
  }
}


  void addLocation(String location) async {
    try {
      await FirebaseFirestore.instance.collection('teams').doc(teamId).update({
        'locations': FieldValue.arrayUnion([location]),
      });
      fetchLocations();
      Get.snackbar(
          'Success',
          'Location added successfully.',
        );
    } catch (e) {
      print('Error adding location: $e');
    }
  }



  //Add location
  TextEditingController locationName = TextEditingController();
  TextEditingController locationDescription = TextEditingController();

  //User Profiling
  TextEditingController userName = TextEditingController();
  TextEditingController language = TextEditingController();
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

    // Upload the image to Firebase Storage
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('itemImages/${DateTime.now().millisecondsSinceEpoch}');
    UploadTask uploadTask = storageReference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String imageURL = await taskSnapshot.ref.getDownloadURL();

    // Update the image path in Firestore and local storage
    final userId = GetStorage().read('id');
    if (userId == null) {
      Get.snackbar('Error', 'No user ID found in storage.');
      return;
    }

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'image': imageURL,
    });

    GetStorage().write('image', imageURL);
    imagePath.value = imageURL;

    Get.snackbar('Success', 'Image uploaded and user updated successfully.');
  } catch (e) {
    print("Error uploading image: $e");
    Get.snackbar('Error', 'Failed to upload image: $e');
  } finally {
    isUploading.value = false;
  }
}

Future<void> updateUsername(String newName) async {
  try {
    final userId = GetStorage().read('id');

    if (userId == null) {
      Get.snackbar('Error', 'No user ID found in storage.');
      return;
    }
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'username': newName,
    });
    GetStorage().write('name', newName);

    Get.snackbar('Success', 'User\'s name updated successfully.');
  } catch (e) {
    print("Error updating username: $e");
    Get.snackbar('Error', 'Failed to update username: $e');
  }
}



  RxBool isSound = true.obs;
  RxBool isVibration = true.obs;

  void fetchTeamCode() async {
    try {
      String? teamId = GetStorage().read('teamId');
      if (teamId == null || teamId.isEmpty) {
        Get.snackbar("Error", "Team ID not found");
        return;
      }

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot teamDoc =
          await firestore.collection('teams').doc(teamId).get();

      if (teamDoc.exists) {
        Map<String, dynamic>? data = teamDoc.data() as Map<String, dynamic>?;
        if (data != null) {
          teamCode.value = data['code'] as String? ?? "";
          update();
        }
      } else {
        Get.snackbar("Error", "Team not found");
      }
    } catch (e) {
      print("Error fetching team code: $e");
    }
  }

  Future<void> changeTeam(String teamId, String mode, String adminId) async {
    try {
      var localStorage = GetStorage();
      await localStorage.write('team_id', teamId);
      await localStorage.write('teamId', teamId);
      await localStorage.write('adminId', adminId);
      await localStorage.write('mode', mode);
      await localStorage.write('currency', '');
      Get.offAllNamed(kNavBarRoute);
    } catch (e) {
      Get.snackbar(
          "Switch Team Error", 'Unable to switch at the moment, try later!');
    }
  }

  Future<void> logout() async {
    try {
      var localStorage = GetStorage();
      await localStorage.write('team_id', '');
      await localStorage.write('id', '');
      await localStorage.write('name', '');
      await localStorage.write('email', '');
      await localStorage.write('image', '');
      await localStorage.write('password', '');
      await localStorage.write('teamId', '');
      await localStorage.write('adminId', '');
      await localStorage.write('mode', '');
      await localStorage.write('currency', '');
      Get.offAllNamed(kLogInRoute);
    } catch (e) {
      Get.snackbar(
          "Logout Error", 'Unable to Logout at the moment, try later!');
    }
  }
}
